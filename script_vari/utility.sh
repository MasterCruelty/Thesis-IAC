#!/bin/bash

#Creazione di un secret su Kubernetes via command line inserendo a mano i campi
kubectl create secret docker-registry regcred --docker-server=localhost:8083/repository/docker-hosted/ --docker-username=admin --docker-password=password

#Per ricavare le info relative ai dati di accesso docker
cat ~/.docker/config.json | base64 -w0

#Applicare il manifesto yaml(presente in questo path) e creare il segreto
#Essenzialmente la stessa procedura fatta sopra ma dando in pasto lo yaml invece di farlo a mano
kubectl create -f secret.yaml
