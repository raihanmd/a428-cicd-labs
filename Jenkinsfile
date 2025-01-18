pipeline {
    agent {
        docker {
            image 'node:lts-buster-slim'
            args '-p 3000:3000'
        }
    }

    environment {
        SSH_KEY_PATH = '/home/lynxdeveloper471.pem'
        SSH_USERNAME = 'lynxdev'
        SSH_HOST = '103.150.197.107'
    }

    stages {
        stage('Build') {
            steps {
                sh 'npm install'
            }
        }
        stage('Test') {
            steps {
                sh './jenkins/scripts/test.sh'
            }
        }
       stage('Delivery') {
            steps {
                sh './jenkins/scripts/deliver.sh'
                echo 'Waiting for 60 seconds...'
                sh 'sleep 60'
                echo 'Stopping the application...'
                sh './jenkins/scripts/kill.sh'
            }
        }
        stage('Manual Approval') {
            steps {
                input message: 'Lanjutkan ke tahap Deploy? (Klik Proceed untuk melanjutkan, atau Abort untuk menghentikan pipeline)'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying to VPS...'
                sh './jenkins/scripts/deploy-to-vps.sh'
            }
        }
    }
}
