# Sử dụng hình ảnh cơ sở Java
FROM openjdk:17-jdk-slim

# Đặt biến môi trường
ENV SPRING_PROFILES_ACTIVE=docker

# Sao chép file JAR vào container
COPY target/apigateway-0.0.1-SNAPSHOT.jar app.jar

# Expose port (chỉnh sửa port theo cấu hình của bạn)
EXPOSE 9000

# Command để chạy ứng dụng
ENTRYPOINT ["java", "-jar", "/app.jar"]
