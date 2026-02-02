#!/bin/bash

###############################################################################
# Deployment Script for Jenkins CI Demo Application
# This script deploys the JAR file to a remote server
###############################################################################

set -e  # Exit on error

# Configuration (Update these variables)
DEPLOY_SERVER="your-server-ip"
DEPLOY_USER="ubuntu"
DEPLOY_PATH="/opt/jenkins-ci-demo"
APP_PORT=8080
JAR_NAME="jenkins-ci-demo-1.0-SNAPSHOT.jar"

echo "=========================================="
echo "Starting deployment process..."
echo "=========================================="

# 1. Check if JAR file exists
if [ ! -f "target/${JAR_NAME}" ]; then
    echo "ERROR: JAR file not found at target/${JAR_NAME}"
    exit 1
fi

echo "✓ JAR file found: target/${JAR_NAME}"

# 2. Create deployment directory on server
echo "Creating deployment directory on server..."
ssh ${DEPLOY_USER}@${DEPLOY_SERVER} "mkdir -p ${DEPLOY_PATH}/backups"

# 3. Backup existing JAR (if exists)
echo "Backing up existing application..."
ssh ${DEPLOY_USER}@${DEPLOY_SERVER} "
    if [ -f ${DEPLOY_PATH}/${JAR_NAME} ]; then
        cp ${DEPLOY_PATH}/${JAR_NAME} ${DEPLOY_PATH}/backups/${JAR_NAME}.backup.\$(date +%Y%m%d_%H%M%S)
        echo '✓ Backup created'
    else
        echo '✓ No existing application to backup'
    fi
"

# 4. Stop the running application
echo "Stopping running application..."
ssh ${DEPLOY_USER}@${DEPLOY_SERVER} "
    PID=\$(pgrep -f ${JAR_NAME}) || true
    if [ -n \"\$PID\" ]; then
        kill \$PID
        echo '✓ Application stopped (PID: '\$PID')'
        sleep 3
    else
        echo '✓ No running application found'
    fi
"

# 5. Copy new JAR to server
echo "Copying new JAR to server..."
scp target/${JAR_NAME} ${DEPLOY_USER}@${DEPLOY_SERVER}:${DEPLOY_PATH}/${JAR_NAME}
echo "✓ JAR copied successfully"

# 6. Start the new application
echo "Starting new application..."
ssh ${DEPLOY_USER}@${DEPLOY_SERVER} "
    cd ${DEPLOY_PATH}
    nohup java -jar ${JAR_NAME} > app.log 2>&1 &
    echo '✓ Application started'
"

# 7. Wait and verify application is running
echo "Verifying application startup..."
sleep 5

ssh ${DEPLOY_USER}@${DEPLOY_SERVER} "
    PID=\$(pgrep -f ${JAR_NAME})
    if [ -n \"\$PID\" ]; then
        echo '✓ Application is running (PID: '\$PID')'
    else
        echo '✗ Application failed to start'
        exit 1
    fi
"

# 8. Health check (optional - if your app has a health endpoint)
# echo "Performing health check..."
# HEALTH_CHECK=$(curl -s -o /dev/null -w "%{http_code}" http://${DEPLOY_SERVER}:${APP_PORT}/health || echo "000")
# if [ "$HEALTH_CHECK" = "200" ]; then
#     echo "✓ Health check passed"
# else
#     echo "⚠ Health check returned: $HEALTH_CHECK"
# fi

echo "=========================================="
echo "✓ Deployment completed successfully!"
echo "=========================================="
echo "Application URL: http://${DEPLOY_SERVER}:${APP_PORT}"
