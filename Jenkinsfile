pipeline {
  agent any

  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub')
    NEXUS_VERSION = "nexus3"
    NEXUS_PROTOCOL = "http"
    NEXUS_URL = "172.10.0.140:8081/"
    NEXUS_REPOSITORY = "maven-nexus-repo"
    NEXUS_CREDENTIAL_ID = "nexus"
    ANYPOINT_CREDENTIALS = credentials('anypoint.credentials')
  }

  stages {
    stage('GIT CHECKOUT') {
      steps {
        echo 'Pulling ... '
        git branch: 'youssef', 
	url: 'https://github.com/olfaBenafia/DevOPs',
	credentialsId: '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'; 
	
	
      }
    }

    stage('TESTING MAVEN') {
      steps {
        sh 'mvn --version'
      }
    }

    stage('MAVEN COMPILE') {
      steps {
        sh 'mvn compile'
      }
    }

    stage('MAVEN PACKAGE') {
      steps {
        sh 'mvn package'
      }
    }

    stage('BUILD DOCKER IMAGE') {
      steps {
        sh 'docker build -t youssefbs/centos .'
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
        sh 'mvn clean deploy -DskipTests'
      }
    }

    stage('DOCKER COMPOSE') {
      steps {
        sh 'docker-compose up -d'
      }
    }

    stage('Deploy Standalone') {
      steps {
        sh 'mvn deploy -P standalone'
      }
    }

    stage('Deploy AnyPoint') {
      steps {
        sh 'mvn deploy -P arm -Darm.target.name=local-4.0.0-ee -Danypoint.username=${ANYPOINT_CREDENTIALS_USR}  -Danypoint.password=${ANYPOINT_CREDENTIALS_PSW}'
      }
    }

    stage('Deploy CloudHub') {
      steps {
        sh 'mvn deploy -P cloudhub -Dmule.version=4.0.0 -Danypoint.username=${ANYPOINT_CREDENTIALS_USR} -Danypoint.password=${ANYPOINT_CREDENTIALS_PSW}'
      }
    }
  }
}
