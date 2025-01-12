node {
    docker.image('node:lts-buster').inside('-p 3000:3000') {
        withEnv(["CI=true"]) {
            try {
                stage('Checkout Repository') {
                    sh 'git clone https://github.com/raihanmd/a428-cicd-labs .'
                }
                
                stage('Switch Branch') {
                    sh 'git checkout react-app'
                }

                stage('Build') {
                    sh 'npm install'
                }

                stage('Test') {
                    sh './jenkins/scripts/test.sh'
                }

                stage('Deliver') {
                    sh './jenkins/scripts/deliver.sh'
                    
                    input message: 'Finished using the website? (Click "Proceed" to continue)'
                    
                    sh './jenkins/scripts/kill.sh'
                }
            } catch (err) {
                echo "Pipeline failed: ${err}"
                throw err
            } finally {
                echo "Final cleanup of workspace"
                deleteDir()
            }
        }
    }
}
