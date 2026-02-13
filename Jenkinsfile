pipeline {
    agent any

    environment {
        IMAGE_NAME = "pooja-springproj-image"
        CONTAINER_NAME = "pooja-javaproject"
    }

    tools {
        maven "Maven-3.9"   // Must match Jenkins Global Tool Configuration
        jdk "JDK-17"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Maven Project') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Remove Existing Container') {
            steps {
                sh '''
                    docker stop $CONTAINER_NAME || true
                    docker rm $CONTAINER_NAME || true
                '''
            }
        }

        stage('Run New Container') {
            steps {
                sh '''
                    docker run -d \
                    --name $CONTAINER_NAME \
                    -p 8082:8080 \
                    $IMAGE_NAME
                '''
            }
        }
    }

    post {
        success {
            echo "Application deployed successfully!"
        }
        failure {
            echo "Pipeline failed!"
        }
        always {
            cleanWs()
        }
    }
}
