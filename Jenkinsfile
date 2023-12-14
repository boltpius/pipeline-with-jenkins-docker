pipeline {
    agent any
    environment{
    DOCKERHUB_CRED = credentials('dockerhub')
}
 
    stages {
        stage('Copy Repo') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/boltpius/pipeline-with-jenkins-docker.git']])
                sh 'ls *'
            }
        }
        stage('Build Docker Image') {
            steps {
                 //sh 'docker build -t boltpius/my-app ./pushdockerimage/' (this will use the tag latest)\
                 // using 'latest' instead of $build_num is not best pratice as it will keep overrirding the image and could become complicated
                //sh 'docker build -t boltpius/my-app:$BUILD_NUMBER ./pushdockerimage/' <- specify where the dockerfile is 
                sh 'docker build . -t boltpius/my-app:$BUILD_NUMBER '
            }
        }
        stage('Docker Login') {
            steps {
                 //sh 'docker login -u $DOCKERHUB_CREDS_USR -p $DOCKERHUB_CREDS_PSW' (this will leave the password visible)
                 // using the one below instead of the above wont make the password show in the logs of the jobs and the  one below is best practice
                sh'echo $DOCKERHUB_CREDS_PSW | docker login -u $DOCKERHUB_CREDS_USR --password-stdin'
            }
        }
        stage('Docker Push') {
            steps {
                //sh 'docker push boltpius/my-app' (this will use the tag latest)    
                sh 'docker push boltpius/my-app:$BUILD_NUMBER'
            }
        }
    }
    post{
        always {
            sh'docker logout'
        }
    }
}
