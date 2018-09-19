pipeline{
    agent any
     stages{
        
         stage('Checkout'){
         steps{
             git credentialsId: 'f182def9-1d2a-4aea-a083-fd780f06125b', url: 'https://github.com/kanny18/myrepo.git'
         }
         }
         stage('Building Maven Project'){
             steps('Build')
             {                 withMaven(
         maven: 'M3'
            ) {
    sh "mvn clean install"
    
    }
             }
         }
      stage ('Bulding dockerimage'){
          steps('Build image from Dockerfile'){
              sh 'sh dockerbuild.sh'
          }
      }
      stage ('Pushing Image to ECR'){
          steps('push image'){
              sh 'sh dockerpush.sh'
          }
          
      }
      stage ('task creation'){
          steps('Task creation for service'){
              sh 'sh task.sh'
          }
          
      }
      stage ('Service creation ECS '){
          steps('Run contaner'){
              sh 'sh service.sh'
          }
          
      }
     }
     post{
           success{
             archiveArtifacts 'target/*.war'
             junit 'target/surefire-reports/*.xml'
           
        }
    }       
    
       
     
    
}
