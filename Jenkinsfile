pipeline {

  agent any

  stages {
   stage('Checkout Source') {
     steps {
       git url:'https://github.com/fabriciolfj/jenkins-k8s', branch:'main'
     }
   }

   stage('Build') {
   steps {
     bat("mvn -Dmaven.test.failure.ignore clean package")
     }
   }

      stage("Build image") {
            steps {
                script {
                    myapp = docker.build("fabricio211/product:latest")
                }
            }
        }

     stage("Push image") {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                            myapp.push("latest")
                    }
                }
            }
        }



    stage('Deploy App') {

      steps {
        script {
            kubernetesDeploy(configs: '**/k8s/**', kubeconfigId: 'kubeconfig')
        }
      }
    }

  }
  }