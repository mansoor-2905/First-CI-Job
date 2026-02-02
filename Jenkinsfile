pipeline {
    agent any
    
    tools {
        maven 'Maven' // Make sure this matches your Jenkins Maven installation name
        jdk 'JDK-11' // Make sure this matches your Jenkins JDK installation name
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out source code...'
                checkout scm
            }
        }
        
        stage('Build') {
            steps {
                echo 'Building the project...'
                sh 'mvn clean compile'
            }
        }
        
        stage('Test') {
            steps {
                echo 'Running unit tests...'
                sh 'mvn test'
            }
            post {
                always {
                    junit '**/target/surefire-reports/*.xml'
                }
            }
        }
        
        stage('Package') {
            steps {
                echo 'Packaging the application...'
                sh 'mvn package -DskipTests'
            }
        }
        
        stage('Code Coverage') {
            steps {
                echo 'Generating code coverage report...'
                sh 'mvn jacoco:report'
            }
            post {
                always {
                    // Publish JaCoCo coverage report
                    jacoco(
                        execPattern: '**/target/jacoco.exec',
                        classPattern: '**/target/classes',
                        sourcePattern: '**/src/main/java'
                    )
                }
            }
        }
        
        stage('Archive') {
            steps {
                echo 'Archiving artifacts...'
                archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    echo 'Building Docker image...'
                    sh """
                        docker build -t jenkins-ci-demo:${BUILD_NUMBER} .
                        docker tag jenkins-ci-demo:${BUILD_NUMBER} jenkins-ci-demo:latest
                    """
                }
            }
        }
        
        stage('Deploy to Server') {
            when {
                branch 'main'
            }
            steps {
                echo 'Deploying application to server...'
                script {
                    // Make deploy script executable
                    sh 'chmod +x deploy.sh'
                    
                    // Execute deployment (requires SSH credentials configured in Jenkins)
                    // Uncomment when ready to deploy
                    // sh './deploy.sh'
                    
                    echo 'NOTE: Deployment script prepared. Configure SSH credentials and uncomment deployment command.'
                }
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
        always {
            echo 'Cleaning up workspace...'
            cleanWs()
        }
    }
}
