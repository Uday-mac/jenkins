FROM eclipse-temurin:21-jdk AS base
WORKDIR /app
RUN apt-get update && apt-install maven -y
COPY . .
RUN mvn clean install

FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=base /app/target/java-jenkins-app.jar app.jar /app/app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]