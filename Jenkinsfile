pipeline {
    agent any
   
    environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub') 
    NEXUS_VERSION = "nexus3"
    NEXUS_PROTOCOL = "http"
    NEXUS_URL = "172.10.0.140:8081/"
    NEXUS_REPOSITORY = "maven-nexus-repo"
    NEXUS_CREDENTIAL_ID = "nexus"
  }
    
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
       stage('BUILD DOCKER IMAGE') {
      steps {
        sh ""
        "docker build -t youssefbs/centos ."
        ""
      }
    }
    stage('PUSH DOCKER IMAGE') {
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR -p $DOCKERHUB_CREDENTIALS_PSW && docker push youssefbs/centos '
      }
    }
    stage(' MVN SONARQUBE') {
      steps {
        withSonarQubeEnv('Sonar') {
          sh 'mvn clean -DskipTests package sonar:sonar'
        }
      }
    }
    stage('MVN NEXUS') {
      steps {
        script {
          sh 'mvn clean deploy -DskipTests'
        }
      }
    }
 
        
    }
}
