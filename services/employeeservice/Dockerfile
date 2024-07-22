FROM openjdk:17-jdk-slim
COPY target/employeeservice-0.0.1-SNAPSHOT.jar employeeservice.jar
COPY src/main/resources/EmployeeServiceAccessKey.json /app/src/main/resources/EmployeeServiceAccessKey.json
ENTRYPOINT ["java","-jar","/employeeservice.jar"]
