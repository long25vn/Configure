pipeline {
    agent any
    stages {
        stage('Clone') {
            steps {
                git 'https://github.com/long25vn/Configure'
            }
        }
        stage('Build') {
            steps {
                dir('/var/jenkins_home/workspace') {
                    sh 'ls'
                }
            }
        }
    }
}
