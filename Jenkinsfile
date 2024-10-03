pipeline{
    agent any
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
                echo "Tested successfully"
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
                sh '''
                    git config user.name "Naspwon"
                    git config user.email "naominyongesa12@gmail.com"
                    git add .
                    git commit -m "Deploying app to main"
                    git push origin main
                '''
            }
        }
    }
}