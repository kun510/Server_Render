#FROM openjdk:17
#VOLUME /tmp
#
#ADD target/api-0.0.1-SNAPSHOT.war api-0.0.1-SNAPSHOT.war
#
#ENTRYPOINT ["java", "-jar", "api-0.0.1-SNAPSHOT.war"]

# Sử dụng một phiên bản Maven và OpenJDK khác
FROM maven:3.8.4-openjdk-17-slim AS build

# Tạo thư mục làm việc /app
WORKDIR /app

# Sao chép tất cả các file từ thư mục hiện tại vào /app
COPY . /app

# Cài đặt Maven và các dependencies
RUN apt-get update && \
    apt-get install -y git && \
    mvn clean install

# Sử dụng image OpenJDK 17 chứa JRE để giảm kích thước
FROM openjdk:17.0.1-jdk-slim

# Tạo thư mục làm việc /app
WORKDIR /app

# Sao chép file WAR từ bước build trước đó
COPY --from=build /app/target/api-0.0.1-SNAPSHOT.war /app/api-0.0.1-SNAPSHOT.war

# Thiết lập entrypoint để chạy ứng dụng khi container khởi động
ENTRYPOINT ["java", "-jar", "api-0.0.1-SNAPSHOT.war"]
