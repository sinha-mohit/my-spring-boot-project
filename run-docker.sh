#!/bin/zsh
# Build the Spring Boot JAR
./gradlew clean build

# Build the Docker image
docker build -t my-spring-boot-project .

# Run the Docker container, mapping port 8080
docker run -d --name my-spring-boot-project -p 8080:8080 my-spring-boot-project

echo "Spring Boot app is running in Docker on http://localhost:8080"
