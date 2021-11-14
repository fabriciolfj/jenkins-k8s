pipeline {

  agent any

  stages {

   def mvnHome
   stage('Preparation') {
        mvnHome = tool 'M2_HOME'
   }

   stage('Checkout Source') {
     steps {
       git url:'https://github.com/fabriciolfj/jenkins-k8s', branch:'main'
     }
   }

   stage('Build') {
      withEnv(["M2_HOME=$mvnHome"]) {
         if (isUnix()) {
            sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore clean package"
         } else {
            bat(/"%M2_HOME%\bin\mvn" -Dmaven.test.failure.ignore clean package/)
         }
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
      steps {
        script {
          kubernetesDeploy(configs: "deploy.yaml", kubeconfigId: "mykubeconfig")
        }
      }
    }

  }

}