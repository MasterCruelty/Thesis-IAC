#!/bin/bash

#Creazione di un secret su Kubernetes via command line inserendo a mano i campi
kubectl create secret docker-registry regcred --docker-server=localhost:8083/repository/docker-hosted/ --docker-username=admin --docker-password=password

#Per ricavare le info relative ai dati di accesso docker
cat ~/.docker/config.json | base64 -w0

#Applicare il manifesto yaml(presente in questo path) e creare il segreto
#Essenzialmente la stessa procedura fatta sopra ma dando in pasto lo yaml invece di farlo a mano
kubectl create -f secret.yaml

#creare private e public pem
openssl genrsa -out keypair.pem 2048
openssl rsa -in keypair.pem -pubout -out public.pem
openssl pkcs8 -topk8 -inform PEM -outform PEM -nocrypt -in keypair.pem -out private.pem
