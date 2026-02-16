# FROM tomcat:9-jdk17

# RUN rm -rf /usr/local/tomcat/webapps/*

# COPY target/JenkinsDemo-0.0.1-SNAPSHOT.jar /usr/local/tomcat/webapps/ROOT.jar

# EXPOSE 8080

# CMD ["catalina.sh", "run"]


# 1️⃣ Use an official Java 17 JDK image for building
FROM eclipse-temurin:17-jdk AS build

# Set working directory
WORKDIR /app

# Copy Maven/Gradle build files first (for caching dependencies)
COPY pom.xml mvnw ./
COPY .mvn .mvn
RUN ./mvnw dependency:go-offline

# Copy source code and build the application
COPY src src
RUN ./mvnw clean package -DskipTests

# 2️⃣ Use a smaller JRE image for running
FROM eclipse-temurin:17-jre

# Set working directory
WORKDIR /app

# Copy the built jar from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose application port
EXPOSE 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]

