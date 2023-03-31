pipeline {
    agent any
   
    stages {
        stage ('Checkout git') {
            steps {
                git branch: 'youssef' ,
                url :'https://github.com/olfaBenafia/DevOpsProject.git'
            }
        }
        stage ('Maven Clean') {
            steps {
                sh 'mvn clean'
            }
        }
        stage ('Maven Compile') {
            steps {
                sh 'mvn compile'
            }
        }
        stage ('Maven Package') {
            steps {
                sh 'mvn package'
            }
        }
        stage ('Unit Test') {
            steps {
                sh 'mvn test'
            }
        }
      stage('Building our image') { 
            steps { 
                script { 
                    dockerImage = docker.build registry + ":$BUILD_NUMBER" 
                }
            } 
        }
        
    }
}
