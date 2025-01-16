pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/username/repo-name.git'
            }
        }
        stage('Install Dependencies') {
            steps {
                sh 'yarn install'
            }
        }
        stage('Build React App') {
            steps {
                sh 'yarn build'
            }
        }
        stage('Deploy to Render') {
            steps {
                withCredentials([string(credentialsId: 'render_api_key', variable: 'RENDER_API_KEY')]) {
                    sh '''
                    curl -X POST \
                         -H "Authorization: Bearer $RENDER_API_KEY" \
                         -H "Content-Type: application/json" \
                         -d '{}' \
                         https://api.render.com/deploy/srv-<YOUR_SERVICE_ID>
                    '''
                }
            }
        }
    }
}
