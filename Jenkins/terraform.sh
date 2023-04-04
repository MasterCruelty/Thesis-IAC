#!/bin/bash
#Ogni credenziale usata come variabile è salvata nel sistema di credenziali di Jenkins, per semplicità ho solo ricopiato i sorgenti bash.

#Viene eseguito in automatico come azione di post-compilazione del primo job che fa solo il clone del repository

#copia dei sorgenti terraform dalla cartella del clone
cp ../Git_clone/src/*.tf .
az login -u $azure_user -p $azure_psw
[ -f terraform.tfstate ] && echo "Uso terraform.tfstate per verificare nuove modifiche"
terraform init
terraform apply -auto-approve 
rs_group=$(terraform output resource_group_name | cut -d '"' -f 2)
cluster_name=$(terraform output kubernetes_cluster_name | cut -d '"' -f 2)
az aks get-credentials --resource-group $rs_group --name $cluster_name
kubectl get nodes

#Successivamente se tutto avviene correttamente parte il job che si occupa del deploy dell'applicazione di test

#copia file yaml dalla cartella del clone
cp ../Git_clone/yaml/*.yaml .
#copia della configurazione terraform
cp ../Terraform/terraform.tfstate .
az login -u $azure_user -p $azure_psw

#mi collego al cluster corrispondente
rs_group=$(terraform output resource_group_name | cut -d '"' -f 2)
cluster_name=$(terraform output kubernetes_cluster_name | cut -d '"' -f 2)
az aks get-credentials --resource-group $rs_group --name $cluster_name

#applico i file yaml
kubectl apply -f *.yaml

#estraggo nome e versione
app=$(grep 'image: ' *.yaml | awk '{print $2}')
version=$(grep 'version: ' catnip.yaml | awk '{print $2}' | sed 's/^"\|"$//g')
#login sul repository docker
sudo docker login -u $docker_usr -p $docker_psw http://localhost:8083/repository/docker-hosted/
#build/tag/push delle immagini
for deploy in $app; do
	tag="$app:$version"
    echo $tag
    #sudo docker build -t "$tag" .
    sudo docker pull $app
    sudo docker tag $app localhost:8083/repository/docker-hosted/$tag
    sudo docker push localhost:8083/repository/docker-hosted/$tag
    sudo docker rmi $app
done
