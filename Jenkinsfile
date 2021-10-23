pipeline {
  agent any
  stages {
    stage('Build Docker Image') {
      when {
        branch 'main'
      }
      steps {
        script {
          app = docker.build("passhag/nx-playground")
          app.inside {
              sh 'echo $(curl localhost:8080)'
          }
        }
      }
    }
    stage('Push Docker Image') {
      when {
        branch 'main'
      }
      steps {
        script {
          docker.withRegistry('https://registry.hub.docker.com', 'docker_hub') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
          }
        }
      }
    }
    stage('DeployToProduction') {
      when {
        branch 'master'
      }
      steps {
        input 'Deploy to Production?'
        milestone(1)
        kubernetesDeploy(
            kubeconfigId: 'kubeconfig',
            configs: 'nx-playground-kubernetes.yml',
            enableConfigSubstitution: true
        )
      }
    }
  } 
}