# Dockerfile for discoveryserver
FROM openjdk:17-slim

WORKDIR /employeeservice

# Copy the JAR file into the container
COPY ./target/employeeservice-0.0.1-SNAPSHOT.jar /employeeservice/employeeservice-0.0.1-SNAPSHOT.jar
COPY src/main/resources/EmployeeServiceAccessKey.json /resources/EmployeeServiceAccessKey.json

# Command to run your application
CMD ["java", "-jar", "employeeservice-0.0.1-SNAPSHOT.jar"]
