# Jenkins CI Demo Project

A simple Java application for testing Jenkins CI pipeline functionality.

## Project Structure

```
CI-project/
├── src/
│   ├── main/
│   │   └── java/
│   │       └── com/
│   │           └── jenkins/
│   │               └── test/
│   │                   └── App.java
│   └── test/
│       └── java/
│           └── com/
│               └── jenkins/
│                   └── test/
│                       └── AppTest.java
├── pom.xml
├── Jenkinsfile
└── README.md
```

## Prerequisites

- Java 11 or higher
- Maven 3.6 or higher
- Jenkins (for CI/CD)

## Building the Project

### Compile the code
```bash
mvn clean compile
```

### Run tests
```bash
mvn test
```

### Package the application
```bash
mvn package
```

### Run the application
```bash
java -jar target/jenkins-ci-demo-1.0-SNAPSHOT.jar
```

Or using Maven:
```bash
mvn exec:java -Dexec.mainClass="com.jenkins.test.App"
```

## Jenkins Pipeline

This project includes a `Jenkinsfile` that defines a complete CI pipeline with the following stages:

1. **Checkout** - Retrieves the source code
2. **Build** - Compiles the Java code
3. **Test** - Runs unit tests
4. **Package** - Creates a JAR file
5. **Archive** - Stores the built artifacts

### Setting up Jenkins

1. Create a new Pipeline job in Jenkins
2. Point it to your repository containing this code
3. Configure the following tools in Jenkins Global Tool Configuration:
   - **Maven**: Named "Maven 3.9.0" (or update the Jenkinsfile to match your Maven installation name)
   - **JDK**: Named "JDK 11" (or update the Jenkinsfile to match your JDK installation name)
4. Run the pipeline

## Features

The application includes:
- Simple greeting functionality
- Basic arithmetic operations
- Even number checking
- Comprehensive unit tests with JUnit 5

## Test Coverage

The project includes 8 unit tests covering:
- Greeting with various inputs (valid name, null, empty string)
- Addition with positive, negative, and zero values
- Even number validation

All tests are automatically run as part of the Jenkins pipeline.
