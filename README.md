# my-spring-boot-project

## MySQL Database Setup

1. Create the database and user in MySQL:

```
mysql -u root -p
```

Then in the MySQL prompt:
```
CREATE DATABASE MySpringBootProject;
CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'newpassword';
GRANT ALL PRIVILEGES ON MySpringBootProject.* TO 'newuser'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

2. Update your `application.properties`:
```
spring.datasource.url=jdbc:mysql://localhost:3306/MySpringBootProject
spring.datasource.username=newuser
spring.datasource.password=newpassword
```

Make sure the database and user exist before running your Spring Boot application.

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

This setup allows you to keep sensitive credentials out of your source code and version control. Make sure to add `.env` to your `.gitignore` file.
