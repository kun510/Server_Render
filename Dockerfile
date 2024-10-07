#FROM openjdk:17
#VOLUME /tmp
#
#ADD target/api-0.0.1-SNAPSHOT.war api-0.0.1-SNAPSHOT.war
#
#ENTRYPOINT ["java", "-jar", "api-0.0.1-SNAPSHOT.war"]

FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY . /app
RUN mvn clean install

# Build the application and skip tests
RUN mvn clean install -DskipTests

FROM openjdk:17.0.1-jdk-slim

WORKDIR /app

COPY --from=build /app/target/api-0.0.1-SNAPSHOT.jar /app/api-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["java", "-jar", "api-0.0.1-SNAPSHOT.jar"]
