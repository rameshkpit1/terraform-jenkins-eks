pipeline {
    agent any
    environment {
        //AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        //AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "us-east-1"
    }
    stages {
        stage('Checkout SCM'){
            steps{
                script{
                    checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/rameshkpit1/terraform-jenkins-eks.git']])
                }
            }
        }
        stage('Initializing Terraform'){
            steps{
                withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws_credentials_for_eks', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                   sh' "echo "hello" '
                }
            }
    }
}
