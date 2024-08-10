pipeline {
    agent any
    environment {
        //AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        //AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "us-east-1"
        cluster_name = 'my-eks-cluster'
    }
    parameters {
            booleanParam(name: 'PLAN_TERRAFORM', defaultValue: false, description: 'Check to plan Terraform changes')
            booleanParam(name: 'APPLY_TERRAFORM', defaultValue: false, description: 'Check to apply Terraform changes')
            booleanParam(name: 'DESTROY_TERRAFORM', defaultValue: false, description: 'Check to apply Terraform changes')
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
                    dir('EKS'){
                        sh 'terraform init'
                        sh ' echo "welcome----------------hello" '
                    }
                }
            }
        }

        stage('Planning Terraform'){
            steps{
                script{
                  if (params.PLAN_TERRAFORM){
                     withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws_credentials_for_eks', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                       dir('EKS'){
                         sh 'terraform plan'
                         sh ' echo "welcome----------------hello" '
                       }
                     }
                  }
                }
            }
        }

        stage('Apply Terraform'){
            steps{
                script{
                  if (params.APPLY_TERRAFORM){
                     withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws_credentials_for_eks', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                       dir('EKS'){
                         sh 'terraform apply -auto-approve'
                         sh ' echo "welcome----------------hello" '
                        }
                      }
                   }
                 }
               }
             }       

        stage('Destroy Terraform'){
            steps{
                script{
                  if (params.DESTROY_TERRAFORM){
                     withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws_credentials_for_eks', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                       dir('EKS'){
                         sh 'terraform destroy -auto-approve'
                         sh ' echo "welcome----------------hello" '
                       }
                     }
                  }
                }
            }
        }

        stage('Deploy into EKS'){
            steps{
                script{
                  if (params.Deploy){
                     withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws_credentials_for_eks', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                       dir('EKS/ConfigurationFiles'){
                         sh 'aws eks update-kubeconfig  --name "${env.cluster_name} '
                         sh ' kubectl get pods '
                       }
                     }
                  }
                }
            }
        }
        
    }
}
