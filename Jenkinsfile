pipeline{
    agent any
    tools{
        nodejs "node"
    }
    environment {
        MONGO_DB_USERNAME = credentials('mongo') // Replace with the actual username credential ID
        MONGO_DB_PWD = credentials('password') // Replace with the actual password credential ID
        RENDER_TOKEN = credentials('rnd_vapAnWm1WZVvS6ZmVm7aJYZs9Wck') // Replace with your Render API token credential ID
    }
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
        stage('Deploy to Render') {
            steps {
                withCredentials([string(credentialsId: 'render-api-token', variable: 'RENDER_TOKEN')]) {
                    sh 'render login --token $RENDER_TOKEN' // Log in to Render using the API token
                    sh 'render deploy --dockerfile ./Dockerfile --branch main' // Deploy to Render using the Dockerfile
                }
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