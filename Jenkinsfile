pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                // Pull code from GitHub
                git branch: 'main', 
                    url: 'https://github.com/poojabhagat25/JenkinsDemo.git'
            }
        }

       stage('Compile'){
            steps{
                // sh 'cd maven'
                sh 'mvn compile'
                // dir('maven') {
                //     sh 'mvn clean compile'
                // }
            }
        }
        
        stage('Build'){
            steps{
                sh 'mvn package'
            }

        }
    }
}
