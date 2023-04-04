#!/bin/bash

#Prima parte della pipeline per il deploy delle modifiche del frontend, solo la parte di compilazione, il resto è identico a deploy.sh

#BUILD CODICE
#copio files dal repository clonato
cp -r ../Git_clone_frontend/frontend .
cd frontend
#installo le dipendenze js
npm install
#compilo e creo una versione pronta per la distribuzione
sudo npm run build
echo "Compilazione avvenuta con successo e build pronta!"

