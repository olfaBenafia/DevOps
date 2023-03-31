pipeline {
  environment {
    registry = "youssefbs/centos"
    registryCredential = 'dockerHub'
    dockerImage = ''
    NEXUS_VERSION = "nexus3"
    NEXUS_PROTOCAOL = "http"
    NEXUS_URL = "172.10.0.140:8081"
    NEXUS_REPOSITORY = "nexus-repo-devops"
    NEXUS_CREDENTIAL_ID = "deploymentRepo"
  }
  agent any 
  stages {
    stage('Checkout GIT') {
      steps {
        git branch: 'youssef', url: 'https://github.com/olfaBenafia/DevOpsProject.git'
      }
    }
    stage('Maven Clean') {
      steps {
        sh 'mvn clean'
      }
    }
    stage('Maven Compile') {
      steps {
        sh 'mvn compile'
      }
    }
    stage('Maven Package') {
      steps {
        sh 'mvn package'
      }
    }
    stage('Unit Test') {
      steps {
        sh 'mvn test'
      }
    }
    stage('Maven SonarQube') {
      steps {
        withSonarQubeEnv('sonar1') {
          sh 'mvn sonar:sonar -Dsonar.login=admin -Dsonar.password=sonar'
        }
      }
    }
    stage("Nexus") {
      steps {
        script {
          sh "mvn deploy"
        }
      }
    }
    stage('Building our image') {
      steps {
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Deploy our image') {
      steps {
        script {
          docker.withRegistry('', registryCredential) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Docker Compose') {
      steps {
        sh ' docker-compose down '
        sh ' docker-compose up --force-recreate -d'
      }
    }
  }
  post {
    success {
      emailext body: "The pipeline has completed successfully", attachLog: true, subject: "Jenkins pipeline completed successfully", to: "youssef.bensaad@esprit.tn"
    }
    failure {
      emailext body: "The pipeline has failed", attachLog: true, subject: "Jenkins pipeline failed", to: "youssef.bensaad@esprit.tn"
    }
  }
}
