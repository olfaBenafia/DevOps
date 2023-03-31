pipeline {
  agent any
  stages {
    stage('Unit Test') {
      steps {
        sh 'mvn clean test'
      }
    }
    stage('Deploy Standalone') {
      steps {
        sh 'mvn deploy -P standalone'
      }
    }
    stage('Deploy AnyPoint') {
      environment {
        ANYPOINT_CREDENTIALS = credentials('anypoint.credentials')
      }
      steps {
        sh 'mvn deploy -P arm -Darm.target.name=local-4.0.0-ee -Danypoint.username=${ANYPOINT_CREDENTIALS_USR}  -Danypoint.password=${ANYPOINT_CREDENTIALS_PSW}'
      }
    }
    stage('Deploy CloudHub') {
      environment {
        ANYPOINT_CREDENTIALS = credentials('anypoint.credentials')
      }
      steps {
        sh 'mvn deploy -P cloudhub -Dmule.version=4.0.0 -Danypoint.username=${ANYPOINT_CREDENTIALS_USR} -Danypoint.password=${ANYPOINT_CREDENTIALS_PSW}'
      }
    }
  }
}
pipeline {
  agent any environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub') 
    NEXUS_VERSION = "nexus3"
    NEXUS_PROTOCOL = "http"
    NEXUS_URL = "172.10.0.140:8081/"
    NEXUS_REPOSITORY = "maven-nexus-repo"
    NEXUS_CREDENTIAL_ID = "nexus"
  }
  stages {
    stage('GIT CHECKOUT') {
      steps {
        echo 'Pulling ... ';
        git branch: 'youssef', url: 'https://github.com/olfaBenafia/DevOPs';
      }
    }
    stage('TESTING MAVEN') {
      steps {
        sh ""
        " mvn --version"
        ""
      }
    }
    stage('MAVEN COMPILE') {
      steps {
        sh ""
        "mvn compile"
        ""
      }
    }
    stage('MAVEN PACKAGE') {
      steps {
        sh ""
        "mvn package"
        ""
      }
    }
    stage('BUILD DOCKER IMAGE') {
      steps {
        sh 'docker build -t tpachat/centos:1.0'   
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
    stage('DOCKER COMPOSE') {
      steps {
        script {
          sh 'docker-compose up -d'
        }
      }
    }
  }
}
