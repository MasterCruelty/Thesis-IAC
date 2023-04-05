#Esempio di Dockerfile per compilazione maven, progetto basato su springboot

#compilazione codice
FROM maven:3.8-openjdk-18-slim AS build
COPY src /src
COPY pom.xml /
RUN mvn -DskipTests -f /pom.xml clean package


FROM openjdk:18-jdk-alpine
COPY --from=build /target/*.jar /app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]

###############################################################
#Esempio di Dockerfile per progetto frontend di un'applicazione basato su nodejs 
FROM node:lts-alpine AS build
WORKDIR /app
COPY package*.json /app/
RUN npm install
COPY ./ /app/
RUN npm run build

FROM nginxinc/nginx-unprivileged
COPY --from=build /app/build/ /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 8080
ENTRYPOINT ["nginx","-g","daemon off;"]

