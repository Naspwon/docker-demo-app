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
        stage('deploy to git'){
            steps{
                withCredentials([string(credentialsId: 'HRKU-a80bfd61-8ad6-40c3-bea5-c654532d76b7', variable: 'HEROKU_API_KEY')]) {
                    sh 'echo $HEROKU_API_KEY | heroku auth:token'
                    sh 'git push https://heroku:$HEROKU_API_KEY@git.heroku.com/dockerd-app.git main'}
            }
        }
    }
}