FROM openjdk:17
VOLUME /tmp

ADD target/api-0.0.1-SNAPSHOT.war api-0.0.1-SNAPSHOT.war

ENTRYPOINT ["java", "-jar", "api-0.0.1-SNAPSHOT.war"]
