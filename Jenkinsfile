pipeline{
    agent any 
    environment{
        DOCKER_IMAGE = "sasibk/weather-app"
    }

    stages{
        stage('Code Checkout'){
            steps{
                git branch: 'main', url: 'https://github.com/sasibeeke/react-weather-app.git'
            }
        }
        stage('Build the Code'){
            steps{
                 def imageTag = "${DOCKER_IMAGE}:${BUILD_NUMBER}"
                 sh "docker build -f Dockerfile -t ${imageTag} ."
            }
        }

        stage('Login to DockerHub'){
            steps{
                withCredentials([usernamePassword(credentialsId:'dockerHub', usernameVariable:'DOCKERHUB_USER', passwordVariable:'DOCKERHUB_PASS')]){
                    sh "echo $DOCKERHUB_PASS | docker login -u $DOCKERHUB_USER --password-stdin"
                }
            }
        }

        stage('Push to Dockerhub'){
            steps{
                def imageTag = "${DOCKER_IMAGE}:${BUILD_NUMBER}"
                sh "docker push ${imageTag}"
            }
        }

    } 

}
