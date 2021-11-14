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
                    myapp = docker.build("fabricio211/product:${env.BUILD_ID}")
                }
            }
        }

      stage("Push image") {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                            myapp.push("latest")
                            myapp.push("${env.BUILD_ID}")
                    }
                }
            }
        }


    stage('Deploy App') {
        environment {
          tag_version = "${env.BUILD_ID}"
        }
      steps {
        script {
            sh 'sed -i "s/{{tag}}/$tag_version/g" ./k8s/deploy.yaml'
            sh 'cat deploy.yaml'
            kubernetesDeploy(configs: '**/k8s/**', kubeconfigId: 'kubeconfig')
        }
      }
    }

  }

    }