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
