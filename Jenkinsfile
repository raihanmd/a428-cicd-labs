pipeline {
    agent any

    environment {
        SSH_KEY_PATH = '/home/.ssh/lynxdeveloper471.pem'
        SSH_USERNAME = 'lynxdev'
        SSH_HOST = '103.150.197.107'
    }

    stages {
        stage('Build') {
            agent {
                docker {
                    image 'node:lts-buster-slim' 
                }
            }
            steps {
                sh 'npm install'
            }
        }
        stage('Test') {
            agent {
                docker {
                    image 'node:lts-buster-slim' 
                }
            }
            steps {
                sh './jenkins/scripts/test.sh'
            }
        }
        stage('Delivery') {
            agent {
                docker {
                    image 'node:lts-buster-slim' 
                    args '-p 3000:3000'
                }
            }
            steps {
                sh './jenkins/scripts/deliver.sh'
                echo 'Visit http://localhost:3000 to see your Node.js/React application in action.'
                echo 'Waiting for 60 seconds...'
                // sh 'sleep 60'
                echo 'Stopping the application in jenkins env'
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

                sh '''
                    whoami
                    ls -l -a /home
                    mkdir -p /var/jenkins_home/.ssh
                    chmod 700 /var/jenkins_home/.ssh
                    touch /var/jenkins_home/.ssh/known_hosts
                    chmod 644 /var/jenkins_home/.ssh/known_hosts
                    ssh-keyscan ${SSH_HOST} >> ~/.ssh/known_hosts
                    ssh -i "$SSH_KEY_PATH" ${SSH_USERNAME}@${SSH_HOST}
                '''

                // sh '''
                //     chmod +x ./jenkins/scripts/deploy-to-vps.sh
                //     ./jenkins/scripts/deploy-to-vps.sh
                // '''
            }
        }
    }
}
