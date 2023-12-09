# Use the Maven image with OpenJDK for building the application
# FROM maven:3.8.4-openjdk-17 AS build

# # Set the working directory to /app
# WORKDIR /app

# # Copy all files from the current directory to /app
# COPY . /app

# # Build the Maven application
# RUN mvn clean install

# # Switch to a different tag for the OpenJDK image
# FROM openjdk:17-jdk-slim

# # Set the working directory to /app
# WORKDIR /app

# # Copy the WAR file from the build stage
# COPY --from=build /app/target/api-0.0.1-SNAPSHOT.war /app/api-0.0.1-SNAPSHOT.war

# # Set the entrypoint to run the application when the container starts
# ENTRYPOINT ["java", "-jar", "api-0.0.1-SNAPSHOT.war"]
FROM maven:3.8.4-openjdk-17 AS build
VOLUME /tmp
ARG api-0.0.1-SNAPSHOT.war
COPY ${/app/target/api-0.0.1-SNAPSHOT.war} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
