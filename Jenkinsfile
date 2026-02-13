pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                // Clone the repository containing the calculator app
               checkout scm // Replace with your actual repository URL
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh 'docker build -t pooja-java .'
                }
            }
        }

        stage('Delete Existing Containers') {
            steps {
                script {
                    // Stop and remove existing containers named shubham-python
                    sh '''
                    if [ "$(docker ps -q -f name=pooja-java)" ]; then
                        docker stop pooja-java
                        docker rm pooja-java
                    fi
                    '''
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Run the Docker container
                    sh 'docker run -d --name pooja-java -p 85:5000 pooja-java'
                }
            }
            
        }
        stage('Check container') {
            steps {
                script {
                    // Run the Docker container
                    sh 'docker container ls -a'
                }
            }
            
        }
    }

    post {
        always {
            // Clean up Docker images and containers if needed
            sh 'docker system prune -f'
        }
    }
}
