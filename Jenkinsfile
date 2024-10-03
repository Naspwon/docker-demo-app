pipeline{
    agent any
    tools{
        nodejs "node"
    }
    // environment {
    //     HEROKU_API_KEY = credentials('HRKU-983ee96b-7abf-4805-8bf7-fd32f92ef428')  // Heroku API key stored in Jenkins
    //     HEROKU_APP_NAME = 'dockerd-app'  // Replace with your Heroku app name
    // }
    stages{
        stage('Clone Repo'){
            steps {
                git (
                    url: 'https://github.com/Naspwon/docker-demo-app.git',
                    branch: 'main')
            }
        }
        stage('Install dependencies'){
            steps{
                sh 'npm install'
            }           
        }
        stage('Run tests'){
            steps{
                echo "Tested successfully..."
            }
        }
        stage('Start application'){
            steps{
                sh 'nohup npm start &'
                sleep 10
                sh 'curl -I http://localhost:3000 || exit 1'
            }
        }
        stage('deploy to heroku.....'){
            steps{
                withCredentials([usernameColonPassword(credentialsId: 'b20864a3-1d63-4d6f-8541-6d56d4f4aa0e', variable: 'HEROKU_CREDENTIALS')]) {
                   sh 'git push https://${HEROKU_CREDENTIALS}@git.heroku.com/dockerd-app.git main' }
            }
        }
    }
    post {
        success {
            slackSend(channel: 'C07PURQG2A3', message: "Build succeeded: ${env.JOB_NAME} #${env.BUILD_NUMBER}")
        }
        failure {
            slackSend(channel: 'C07PURQG2A3', message: "Build failed: ${env.JOB_NAME} #${env.BUILD_NUMBER}")
        }
    }
}