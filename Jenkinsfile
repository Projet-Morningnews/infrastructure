pipeline {
  agent any

  environment {
    TFC_TOKEN = credentials('TFC_API_TOKEN') //
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Terraform Init') {
      steps {
        sh '''
          terraform login --token=$TFC_TOKEN
          terraform init
        '''
      }
    }

    stage('Terraform Plan') {
      steps {
        sh 'terraform plan'
      }
    }

    stage('Terraform Apply') {
      when {
        branch 'main'
      }
      steps {
        sh 'terraform apply -auto-approve'
      }
    }
    stage('Terraform Outputs') {
        steps {
            sh '''
              echo "Outputs:"
                terraform output
              '''
            }
        }
    stage('Build Info') {
        steps {
            sh '''
                echo "Job: $JOB_NAME"
                echo "Build: $BUILD_NUMBER"
                echo "Date: $(date)"
                echo "Branch Name: $GIT_BRANCH"
                echo "Commit Number: $GIT_COMMIT"
            '''
        }
    }
  }
}