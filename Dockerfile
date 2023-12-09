# Sử dụng hình ảnh Maven đầy đủ với OpenJDK
FROM maven:3.8.4-openjdk-17 AS build

# Tạo thư mục làm việc /app
WORKDIR /app

# Sao chép tất cả các file từ thư mục hiện tại vào /app
COPY . /app

# Build ứng dụng Maven
RUN mvn clean install

# Chuyển sang giai đoạn mới để giảm kích thước của ảnh
FROM openjdk:17.0.1-jdk-slim

# Tạo thư mục làm việc /app
WORKDIR /app

# Sao chép file WAR từ giai đoạn trước
COPY --from=build /app/target/api-0.0.1-SNAPSHOT.war /app/api-0.0.1-SNAPSHOT.war

# Thiết lập entrypoint để chạy ứng dụng khi container khởi động
ENTRYPOINT ["java", "-jar", "api-0.0.1-SNAPSHOT.war"]
