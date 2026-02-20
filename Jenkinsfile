@Library('pooja-shared-lib') _


pipeline {
    agent any

    environment {
        IMAGE_NAME = "poojabhagat/jenkinsdemo"
        CONTAINER_NAME = "pooja-java-app-container"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Maven') {
            steps {
                pakageClean()
            }
        }

        stage('Remove Old Container') {
            steps {
               removeContainer()
            }
        }

        stage('Remove Old Image') {
            steps {
                sh '''
                docker rmi -f ${IMAGE_NAME}:latest || true
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                docker build -t ${IMAGE_NAME}:latest .
                '''
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'pooja_creds',
                                                 usernameVariable: 'DOCKER_USER',
                                                 passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                    '''
                }
            }
        }

        stage('Push Image to DockerHub') {
            steps {
                sh '''
                docker push ${IMAGE_NAME}:latest
                '''
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                docker run -d -p 9090:8080 --name ${CONTAINER_NAME} ${IMAGE_NAME}:latest
                '''
            }
        }
    }
}
