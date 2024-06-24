# Dockerfile for discoveryserver
FROM openjdk:17-slim

WORKDIR /discoveryserver

# Copy the JAR file into the container
COPY ./target/discoveryserver-0.0.1-SNAPSHOT.jar /discoveryserver/discoveryserver-0.0.1-SNAPSHOT.jar

# Command to run your application
CMD ["java", "-jar", "discoveryserver-0.0.1-SNAPSHOT.jar"]
