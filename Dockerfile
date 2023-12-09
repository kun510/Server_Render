# Sử dụng hình ảnh Maven đầy đủ với OpenJDK để build ứng dụng
FROM maven:3.8.4-openjdk-17 AS build

# Tạo thư mục làm việc /app
WORKDIR /app

# Sao chép tất cả các file từ thư mục hiện tại vào /app
COPY . /app

# Build ứng dụng Maven
RUN mvn clean install

# Chuyển sang hình ảnh OpenJDK 17 để giảm kích thước của ảnh
FROM openjdk:17-jre-slim

# Tạo thư mục làm việc /app
WORKDIR /app

# Sao chép file WAR từ giai đoạn build trước
COPY --from=build /app/target/api-0.0.1-SNAPSHOT.war /app/api-0.0.1-SNAPSHOT.war

# Thiết lập entrypoint để chạy ứng dụng khi container khởi động
ENTRYPOINT ["java", "-jar", "api-0.0.1-SNAPSHOT.war"]
