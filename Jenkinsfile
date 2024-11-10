pipeline {
    agent any
	
    environment {
        GOOGLE_APPLICATION_CREDENTIALS = credentials('gcp-jenkins-key')
	    GIT_TOKEN = credentials('git-jenkins-token')
    }
	
    stages {        

         stage('Check Branch') {
            when {
                branch 'main'
            }
            steps {
                echo "This is the main branch. Proceeding with Terraform steps."
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