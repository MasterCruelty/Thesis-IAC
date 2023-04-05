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
