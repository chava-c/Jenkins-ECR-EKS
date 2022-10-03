pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID="113304117666"
        AWS_DEFAULT_REGION="us-east-1" 
        IMAGE_REPO_NAME="pipeline-repository"
        IMAGE_TAG="${BUILD_NUMBER}"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
    }
    stages{
        stage('Logging into AWS ECR') {
            steps {
               script {
                  sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
              }
           }
        }
        stage('Cloning Git') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/chava-c/Jenkins-ECR-EKS.git']]])
            }
        }
        stage('Building image') {
            steps{
                script {
                    dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}"
                }
            }
        }
        stage('Pushing to ECR') {
            steps{
                script {
                    sh "docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:$IMAGE_TAG"
                    sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:${IMAGE_TAG}"
                }
            }
        }
        stage('deploy EKs cluster'){
            steps{
                script{
                    sh 'aws sts get-caller-identity'
                    sh 'aws eks update-kubeconfig --region us-east-1  --name demo'
                    //sh 'kubectl get svc'
                    //sh 'kubectl get nodes'
                    //sh 'kubectl get pods'
                    //sh 'kubectl get all'

                    sh 'sed -i "s;latest;$IMAGE_TAG;" eks-web-deployment.yaml'
                 
                    sh 'kubectl rollout restart deployment -n eks-sample-app'
                    sh 'kubectl apply -f eks-web-deployment.yaml --record=true'
                    sh 'kubectl apply -f eks-web-service.yaml'
                }
            }
        }
    }
}