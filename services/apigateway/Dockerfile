# Dockerfile for apigateway
FROM openjdk:17-slim

WORKDIR /apigateway

# Copy the JAR file into the container
COPY ./target/apigateway-0.0.1-SNAPSHOT.jar /apigateway/apigateway-0.0.1-SNAPSHOT.jar

# Command to run your application
CMD ["java", "-jar", "apigateway-0.0.1-SNAPSHOT.jar"]
