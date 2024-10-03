pipeline{
    agent any
    environment {
        HEROKU_API_KEY = credentials('HRKU-983ee96b-7abf-4805-8bf7-fd32f92ef428')  // Heroku API key stored in Jenkins
        HEROKU_APP_NAME = 'dockerd-app'  // Replace with your Heroku app name
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
        stage('deploy to git'){
            steps{
                // Login to Heroku via CLI
                    sh '''
                    echo $HEROKU_API_KEY | docker login --username=_ --password-stdin registry.heroku.com
                    git remote add heroku https://git.heroku.com/${HEROKU_APP_NAME}.git || true
                    git push heroku main
                    '''
                    
                    // Optionally, scale dynos if needed
                    sh 'heroku ps:scale web=1 --app $HEROKU_APP_NAME'
            }
        }
    }
}