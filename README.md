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

This project includes a comprehensive `Jenkinsfile` that defines a complete CI/CD pipeline with the following stages:

1. ✅ **Checkout** - Retrieves the source code from GitHub
2. ✅ **Build** - Compiles the Java code using Maven
3. ✅ **Test** - Runs all unit tests and generates reports
4. ✅ **Package** - Creates an executable JAR file
5. ✅ **Code Coverage** - Generates JaCoCo code coverage reports
6. ✅ **Archive** - Stores build artifacts in Jenkins
7. ✅ **Build Docker Image** - Creates containerized version of the app
8. ✅ **Deploy to Server** - Automated deployment to production server (optional)

### Pipeline Features

- **Automated Testing**: 8 comprehensive JUnit tests
- **Code Quality**: JaCoCo coverage with 50% minimum threshold
- **Artifact Management**: JAR files archived with fingerprinting
- **Containerization**: Multi-stage Docker builds for efficiency
- **Deployment**: Automated deployment with rollback capability
- **GitHub Webhooks**: Auto-trigger builds on git push

---

## Setting up Jenkins

### Initial Setup

1. Create a new Pipeline job in Jenkins
2. Point it to your repository: `https://github.com/mansoor-2905/First-CI-Job.git`
3. Configure the following tools in Jenkins Global Tool Configuration:
   - **Maven**: Named "Maven"
   - **JDK**: Named "JDK-11"
4. Run the pipeline

### Enable Automatic Builds (Webhook Setup)

See [WEBHOOK_SETUP.md](WEBHOOK_SETUP.md) for detailed instructions on configuring GitHub webhooks.

**Quick setup:**
1. In Jenkins job → Configure → Build Triggers → Enable "GitHub hook trigger for GITScm polling"
2. In GitHub repo → Settings → Webhooks → Add: `http://your-jenkins-ip:8080/github-webhook/`

---

## Docker Support

### Build Docker Image Locally

```bash
# Build the image
docker build -t jenkins-ci-demo:latest .

# Run the container
docker run -p 8080:8080 jenkins-ci-demo:latest

# Or use docker-compose
docker-compose up
```

### Docker Image Features

- **Multi-stage build** for minimal image size
- Based on OpenJDK 11 slim image
- Includes health checks
- Production-ready configuration

---

## Deployment

### Automated Deployment

The pipeline includes an automated deployment stage that:
1. Backs up the existing application
2. Stops the running instance
3. Deploys the new JAR file
4. Starts the application
5. Verifies deployment success

### Configure Deployment

Edit `deploy.sh` and update these variables:

```bash
DEPLOY_SERVER="your-server-ip"
DEPLOY_USER="ubuntu"
DEPLOY_PATH="/opt/jenkins-ci-demo"
APP_PORT=8080
```

Then configure SSH credentials in Jenkins:
1. **Manage Jenkins** → **Credentials** → **Add Credentials**
2. Kind: **SSH Username with private key**
3. ID: `deployment-ssh-key`
4. Add your private key

Uncomment the deployment line in `Jenkinsfile`:
```groovy
sh './deploy.sh'
```

---

## Code Quality & Coverage

### JaCoCo Code Coverage

The pipeline automatically generates code coverage reports:

- **Minimum threshold**: 50% line coverage
- **Reports location**: `target/site/jacoco/index.html`
- **Jenkins integration**: Coverage trends visible in build history

### View Coverage Report

```bash
# Generate locally
mvn clean test jacoco:report

# Open report
open target/site/jacoco/index.html
```

### SonarQube Integration (Optional)

For advanced code quality analysis:

1. Set up a SonarQube server
2. Update `sonar-project.properties` with your server details
3. Add SonarQube stage to Jenkinsfile:

```groovy
stage('SonarQube Analysis') {
    steps {
        sh 'mvn sonar:sonar'
    }
}
```

---

## Features

The application includes:
- ✅ Simple greeting functionality with null/empty handling
- ✅ Basic arithmetic operations (addition)
- ✅ Even number validation
- ✅ Comprehensive unit tests with JUnit 5 (8 tests total)
- ✅ Code coverage tracking with JaCoCo
- ✅ Docker containerization
- ✅ Automated deployment scripts

## Project Enhancements

This project demonstrates modern DevOps practices:

- **CI/CD Pipeline**: Fully automated build, test, and deployment
- **Quality Gates**: Code coverage thresholds enforced
- **Containerization**: Docker support for consistent deployments
- **Infrastructure as Code**: Pipeline defined in Jenkinsfile
- **Automated Testing**: Unit tests run on every commit
- **GitHub Integration**: Webhooks for automatic build triggers

---

## Test Coverage

The project includes 8 comprehensive unit tests:

| Test Category | Tests | Description |
|--------------|-------|-------------|
| Greeting | 3 | Valid name, null, empty string |
| Addition | 3 | Positive, negative, zero |
| Even Check | 2 | True cases, false cases |

All tests run automatically in the CI pipeline with coverage reporting.

---

## Troubleshooting

### Build Fails in Jenkins

Check tool configurations match:
```bash
# Verify on Ubuntu server
java -version  # Should be Java 11
mvn --version
docker --version
```

### Docker Build Fails

Ensure Docker is installed on Jenkins server:
```bash
sudo apt install docker.io -y
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins
```

### Deployment Fails

1. Verify SSH connectivity from Jenkins to deployment server
2. Check `deploy.sh` configuration variables
3. Ensure deployment directory exists and has write permissions
4. Verify application port (8080) is available

---

## Additional Resources

- **Webhook Setup**: See [WEBHOOK_SETUP.md](WEBHOOK_SETUP.md)
- **Deployment Guide**: See comments in [deploy.sh](deploy.sh)
- **Docker Guide**: See [Dockerfile](Dockerfile)
- **Code Quality**: See [sonar-project.properties](sonar-project.properties)

---

## What's Next?

Consider adding:
- ✅ Integration tests
- ✅ Performance testing
- ✅ Security scanning (OWASP Dependency Check)
- ✅ Multi-environment deployments (dev, staging, prod)
- ✅ Kubernetes deployment manifests
- ✅ Monitoring and logging integration
