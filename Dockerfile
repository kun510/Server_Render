# Stage 1: Build the application using Maven
FROM maven:3.8.5-openjdk-17 AS build

# Set working directory
WORKDIR /app

# Copy the project files
COPY . /app

# Build the application and skip tests
RUN mvn clean install -DskipTests

# Stage 2: Run the application
FROM openjdk:17.0.1-jdk-slim

# Set working directory
WORKDIR /app

# Copy the built jar from the previous stage
COPY --from=build /app/target/api-0.0.1-SNAPSHOT.jar /app/api-0.0.1-SNAPSHOT.jar

# Set the entry point to run the application
ENTRYPOINT ["java", "-jar", "api-0.0.1-SNAPSHOT.jar"]
