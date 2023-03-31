pipeline {
    agent any
    
    environment {
    		DOCKERHUB_CREDENTIALS=credentials('docker_hub')
    		}

    stages {
        stage('Checkout GIT') {
            steps {
                echo 'Pulling... ';
                    git branch: 'youssef',
                        url : 'https://github.com/olfaBenafia/DevOPs',
                        credentialsId: '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';
            }
        }
        stage('Cleaning the project') {     
            steps {
                echo 'cleaning project ...'
                sh 'mvn clean package'
            }
        }
        
        stage('Compiling the artifact') {             
            steps {
                echo "compiling"
                sh 'mvn compile'
            }
        }
        stage ('Docker build') {
             steps {
            sh ' docker build -t tpachat/centos:1.0'
            }
        }
        stage ('Docker login'){
        	steps {
        	sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR -p $DOCKERHUB_CREDENTIALS_PSW'
        	}
        }
        stage ('Docker push'){
        	steps {
        	sh 'docker push youssefbs/centos'
        	}
        }
        stage ('Docker logout'){
        	steps {
        	sh 'docker logout'
        	}
        }
        
      }
}
