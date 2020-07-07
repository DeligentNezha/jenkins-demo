pipeline {
    agent any
    tools {
        maven "Maven"
    }

    stages {
        stage('Build') {
            steps {
                sh 'mvn clean'
                sh 'mvn install'
                sh 'mvn package -P test'
            }
        }
//         stage('Test') {
//             steps {
//                 sh 'mvn test'
//             }
//             post {
//                 always {
//                     junit 'target/surefire-reports/*.xml'
//                 }
//             }
//         }
        stage('Deploy') {
            steps {
                echo "当前用户: ${USER}"
                echo "当前目录: ${PWD}"
                echo "当前工作目录: ${WORKSPACE}"
//                 echo '本地安装'
//                 sh 'mvn jar:jar install:install help:evaluate -Dexpression=project.name -Dmaven.repo.local=/home/admin/.m2/repository'

                sh "JENKINS_NODE_COOKIE=dontKillMe nohup java -jar target/diabetes_monitor-api.jar > app.log 2>&1 &"
//                 sh './track-core/jenkins/scripts/deliver.sh'
            }
        }
    }
}
