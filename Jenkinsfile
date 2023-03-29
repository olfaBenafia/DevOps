pipeline {
    agent any
    
    environment {
    		DOCKERHUB_CREDENTIALS=credentials('docker_hub')
    		}

    stages {
        stage('Checkout GIT') {
            steps {
                echo 'Pulling... ';
                    git branch: 'obenafia',
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
        
//          stage ("Nexuspackage"){
// 			steps{
// 			sh "mvn package -DskipTests"          
//             } 
//         }
//         stage('NEXUS') {
//             steps {
//                 sh 'mvn clean deploy -Dmaven.test.skip=true -Dresume=false'
//             }
//         }
// 	 stage('SONAR') {
//             steps {
//                 sh 'mvn sonar:sonar -Dsonar.login=admin -Dsonar.password=olfa1999'
//             }
// 	 }
	    
        stage ('Docker build') {
             steps {
            sh ' docker build -t olfabenafia/tpachatproject-1.0:latest .'
            }
        }
        stage ('Docker login'){
        	steps {
        	sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR -p $DOCKERHUB_CREDENTIALS_PSW'
        	}
        }
        stage ('Docker push'){
        	steps {
        	sh 'docker push olfabenafia/tpachatproject-1.0:latest'
        	}
        }
        stage ('Docker logout'){
        	steps {
        	sh 'docker logout'
        	}
        }
        
      }

    
    
}
