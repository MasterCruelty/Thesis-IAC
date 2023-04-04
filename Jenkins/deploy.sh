#!/bin/bash

#######################################################
#BUILD CODICE

#copio files dal repository clonato
cp -r ../Git_clone_quiz/interviewtool-microservizio-quiz/interviewtool.quiz/ .
cd interviewtool.gateway
#setto var di ambiente maven per Jenkins
export MAVEN_HOME=/usr/local/src/apache-maven
export PATH=$PATH:$MAVEN_HOME/bin
mvn --version
export JAVA_HOME=/opt/jdk-18
export PATH=$PATH:$JAVA_HOME/bin
#Compilazione e build del codice
mvn clean package spring-boot:repackage -DskipTests



#######################################################
#BUILD IMMAGINE


#copio i file dal repository clonato
cp -r ../Build_quiz/ .
cd Build_quiz/interviewtool.quiz
#login sul repository docker
sudo docker login -u $docker_usr -p $docker_psw http://localhost:8083/repository/docker-hosted/
#Buildo l'immagine dal Dockerfile(setto nome immagine e prelevo ultimo numero di versione dal repo docker)
img=interview_quiz
version=$(sudo docker images localhost:8083/repository/docker-hosted/interview_quiz --format "{{.Tag}}" | grep -A 1 latest | awk 'NR==2')
if [ -z "$version" ]; then
	version="v1"
else
    #estraggo il numero di versione e lo incremento di 1
    version_number=$(echo "$version" | cut -c 2-)
    new_version_number=$((version_number + 1))
    version="v$new_version_number"
fi
sudo docker build -t $img .

#taggo l'immagine
sudo docker tag $img localhost:8083/repository/docker-hosted/$img:latest
sudo docker tag $img localhost:8083/repository/docker-hosted/$img:$version
#push dell'immagine su repository docker Nexus
sudo docker push localhost:8083/repository/docker-hosted/$img:latest
sudo docker push localhost:8083/repository/docker-hosted/$img:$version

echo "Immagine buildata, versionata e pushata su Nexus con successo!"



#######################################################
#DEPLOY KUBERNETES


#copia della configurazione terraform
cp ../Terraform/terraform.tfstate .
#azure login
az login -u $azure_usr -p $azure_psw
#mi collego al cluster kubernetes
rs_group=$(terraform output resource_group_name | cut -d '"' -f 2)
cluster_name=$(terraform output kubernetes_cluster_name | cut -d '"' -f 2)
az aks get-credentials --resource-group $rs_group --name $cluster_name
kubectl get nodes
echo "Collegamento al cluster avvenuto con successo!"
#deploy del manifesto yaml del servizio
cp ../Git_clone_quiz/interviewtool-microservizio-quiz/interviewtool.quiz/quiz.yaml .
kubectl apply -f quiz.yaml
kubectl get svc
echo "manifesto yaml deployato con successo"
