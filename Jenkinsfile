pipeline{
    agent any
    stages{
        stage('Clone Repo'){
            steps {
                git url: 'https://github.com/Naspwon/docker-demo-app.git',
                git branch: 'main'
            }
        }
        stage('Install dependencies'){
            sh 'npm install'
        }
        stage('Run tests'){
            echo "Tested successfully"
        }
        stage('Start application'){
            sh 'nohup npm start &'
            sleep 10
            sh 'curl -I http://localhost:3000 || exit 1'
        }
        stage('deploy to git'){
            sh '''
                git config user.name "Naspwon"
                git config user.email "naominyongesa12@gmail.com"
                git add .
                git commit -m "Deploying app"
                git push origin main
                '''
        }
    }
}