# Multi-stage Dockerfile for Jenkins CI Demo Application

# Stage 1: Build the application
FROM maven:3.9-openjdk-11 AS builder

# Set working directory
WORKDIR /app

# Copy pom.xml and download dependencies (cache layer)
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy source code
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Stage 2: Create runtime image
FROM openjdk:11-jre-slim

# Set working directory
WORKDIR /app

# Copy JAR from builder stage
COPY --from=builder /app/target/jenkins-ci-demo-1.0-SNAPSHOT.jar app.jar

# Expose port (if your app uses one, otherwise remove this)
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]

# Health check (optional)
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD java -version || exit 1
