#FROM openjdk:17
#VOLUME /tmp
#
#ADD target/api-0.0.1-SNAPSHOT.war api-0.0.1-SNAPSHOT.war
#
#ENTRYPOINT ["java", "-jar", "api-0.0.1-SNAPSHOT.war"]

FROM maven:3.9.6-openjdk-17-slim AS build
WORKDIR /app
COPY . /app
RUN mvn clean install
FROM openjdk:17-jre-slim

WORKDIR /app

COPY --from=build /app/target/api-0.0.1-SNAPSHOT.war /app/api-0.0.1-SNAPSHOT.war
ENTRYPOINT ["java", "-jar", "api-0.0.1-SNAPSHOT.war"]
