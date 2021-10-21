pipeline {
  agent any
  stages {
    stage('Build Docker Image') {
      when {
        branch 'master'
      }
      steps {
        script {
          app = docker.build('passhag/nx-playground')
          app.inside {
            sh 'echo ${curl localhost:8080}'
          }
        }
      }
    }
    stage('Push Docker Image') {
      when {
        branch 'master'
      }
      steps {
        script {
          docker.withRegistry('https://registry.hub.docker.com', 'passhag') {
              app.push("${env.BUILD_NUMBER}")
              app.push("latest")
          }
        }
      }
    }
  }
}