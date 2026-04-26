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
                script {
                 def imageTag = "${DOCKER_IMAGE}:${BUILD_NUMBER}"
                 sh "docker build -f Dockerfile -t ${imageTag} ."
            }
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
                script {
                def imageTag = "${DOCKER_IMAGE}:${BUILD_NUMBER}"
                sh "docker push ${imageTag}"
            }
            }
        }

        /*stage('Run Container (Test)') {
            steps {
                sh '''
                docker run -d -p 3000:3000 \
                -e REACT_APP_API_KEY=de0ed5aadcmshb4eb1566860eecep1cc1ddjsne00fd7d03e20 \
                ${DOCKER_IMAGE}:${BUILD_NUMBER}
                '''
            }
        }*/

        stage('Deploy to EKS') {
            steps {
                script {
                    sh """
                    kubectl apply -f kubernetes/
                    """
                }
            }
        }

    } 

}
