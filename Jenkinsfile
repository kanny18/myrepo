pipeline{
properties([buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '5', numToKeepStr: '')), pipelineTriggers([pollSCM('H/5 * * * * ')])])
    agent any
     stages{
        
         stage('Checkout'){
         steps{
             checkout  scm: [$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'a1700635-21c6-4fb8-bea4-28a3a7d15204', url: 'https://github.com/kanny18/myrepo.git']]]
             //checkout changelog: false, poll: false, scm: [$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'test']], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'a1700635-21c6-4fb8-bea4-28a3a7d15204', url: 'https://github.com/kanny18/repo.git']]]
             checkout poll:false, changelog:false, scm:[$class: 'GitSCM', branches: [[name: '*/master']],
                    doGenerateSubmoduleConfigurations: false, extensions: [ [$class: 'RelativeTargetDirectory', relativeTargetDir: "build_script/"],[$class: 'DisableRemotePoll'],[$class: 'PathRestriction', excludedRegions: '', includedRegions: '*'],
                    [$class: 'SparseCheckoutPaths',  sparseCheckoutPaths:[[$class:'SparseCheckoutPath', path:'test']]]],
                    submoduleCfg: [],
                    userRemoteConfigs: [[credentialsId: 'a1700635-21c6-4fb8-bea4-28a3a7d15204',
                    url: 'https://github.com/kanny18/repo.git']]])
                    //sh 'cp build_script/DarkChat/DarkChat_MR11_IOS/*.sh . '
             //checkout changelog: false, poll: false, scm: [$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'a1700635-21c6-4fb8-bea4-28a3a7d15204', url: 'https://github.com/kanny18/repo.git']]]
             //git credentialsId: '<######f9-1d2a-4aea-a083-fd780f#######>', url: 'https://github.com/kanny18/myrepo.git'
         }
         }
         stage('Building a Maven Project'){
             steps('Build')
             {                 withMaven(
         maven: 'M3'
            ) {
    sh "mvn clean install"
    
    }
   ///          }
         }
      stage ('Bulding dockerimage'){
          steps('Build image from Dockerfile'){
              sh 'sh dockerbuild.sh'
          }
      }
      stage ('Pushing Image to ECR ONCE'){
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
