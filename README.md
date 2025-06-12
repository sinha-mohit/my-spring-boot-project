# my-spring-boot-project

## MySQL Database Setup

1. Create the database and user in MySQL:

```sh
mysql -u root -p
```

Then in the MySQL prompt:
```sql
CREATE DATABASE MySpringBootProject;
CREATE USER 'springbootuser'@'localhost' IDENTIFIED BY 'springbootuser';
GRANT ALL PRIVILEGES ON MySpringBootProject.* TO 'springbootuser'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

2. Update your `src/main/resources/application.properties`:
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/MySpringBootProject
spring.datasource.username=${MYSQL_USER}
spring.datasource.password=${MYSQL_PASSWORD}
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
```

## Using .env for MySQL Credentials in Spring Boot

Spring Boot does not natively support .env files, but you can use the dotenv-java library to load environment variables from a .env file.

### Steps:

1. **Add the dependency to your `build.gradle`:**
   ```groovy
   implementation 'io.github.cdimascio:dotenv-java:3.0.0'
   ```

2. **Create a `.env` file in your project root:**
   ```env
   MYSQL_USER=username
   MYSQL_PASSWORD=password
   ```

3. **Update your `application.properties`:**
   ```properties
   spring.datasource.username=${MYSQL_USER}
   spring.datasource.password=${MYSQL_PASSWORD}
   ```

4. **Load the .env file in your main application class:**
   ```java
   import io.github.cdimascio.dotenv.Dotenv;
   // ...existing code...
   public static void main(String[] args) {
       Dotenv dotenv = Dotenv.configure().ignoreIfMissing().load();
       System.setProperty("MYSQL_USER", dotenv.get("MYSQL_USER"));
       System.setProperty("MYSQL_PASSWORD", dotenv.get("MYSQL_PASSWORD"));
       SpringApplication.run(MySpringBootProjectApplication.class, args);
   }
   // ...existing code...
   ```

## Logging and ELK Integration

- Logging is configured in `src/main/resources/logback-spring.xml` to output logs in JSON format, suitable for ELK (Elasticsearch, Logstash, Kibana).
- Logs are written to both the console and to `logs/app-log.json`.
- The log pattern includes rich context: timestamp, level, thread, logger, message, MDC, exception, caller, class, method, file, line, application, host, traceId, spanId, user, requestId, uri, remoteAddr, and more.
- Log generation is handled by `LogGenerator` in the `logging` package, which produces 300 logs per minute at various log levels.

## Dockerization

A `Dockerfile` is provided to containerize the application:

```
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
COPY build/libs/my-spring-boot-project-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]
```

## Running with Docker

A shell script `run-docker.sh` is included to automate the build and run process:

```
#!/bin/zsh
./gradlew clean build
docker build -t my-spring-boot-project .
docker run -d --name my-spring-boot-project -p 8080:8080 my-spring-boot-project
echo "Spring Boot app is running in Docker on http://localhost:8080"
```

To use:
```sh
chmod +x run-docker.sh
./run-docker.sh
```

## Notes
- Make sure your MySQL server is running and accessible from the Docker container (use host networking or set up a Docker network if needed).
- The application will continuously generate logs for ELK/Kibana analysis.
- You can customize log generation, log format, and Docker settings as needed.
