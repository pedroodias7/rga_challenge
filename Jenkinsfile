pipeline {
    agent any
	
    environment {
        GOOGLE_APPLICATION_CREDENTIALS = credentials('gcp-jenkins-key')
	    GIT_TOKEN = credentials('git-jenkins-token')
    }
	
    stages {
        stage('Git Checkout') {
            steps {
               git "https://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@github.com/pedroodias7/rga_challenge.git"
            }
        }
        
        stage('Terraform Init') {
            steps {
                script {
                    sh 'terraform init'
                }
            }
        }
        
        stage('Terraform Plan') {
            steps {
                script {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

	    stage('Manual Approval') {
            steps {
                input "Approve?"
            }
        }
	    
        stage('Terraform Apply') {
            steps {
                script {
                    sh 'terraform apply tfplan'
                }
            }
        }
    }
}