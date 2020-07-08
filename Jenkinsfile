//#!/usr/bin/env groovy
pipeline {
//     agent { docker 'maven:3-alpine' }
    agent any

    environment {
        CC = 'clang'
    }

    tools {
        maven "Maven"
    }

    stages {
        stage('Agent Check') {
            agent { docker 'openjdk:8-jre' }
            steps {
                echo 'agent in stage'
                echo 'jre check'
                sh 'java -version'
            }
        }

        stage('Env Check') {
            environment {
                AN_ACCESS_KEY = credentials('github')
            }
            steps {
                sh 'printenv'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean'
                sh 'mvn install'
                sh 'mvn package'
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

                sh 'cp ${WORKSPACE}/target/jenkins-demo.jar /opt/jar'
                sh "JENKINS_NODE_COOKIE=dontKillMe nohup java -jar /opt/jar/jenkins-demo.jar > /opt/jar/app.log 2>&1 &"
//                 sh './track-core/jenkins/scripts/deliver.sh'
            }
        }
    }
    post {
        always {
            echo 'pipeline post always !'
        }

        changed {
            echo 'pipeline post changed !'
        }

        fixed {
            echo 'pipeline post fixed !'
        }

        regression {
            echo 'pipeline post regression !'
        }

        aborted {
            echo 'pipeline post aborted !'
        }

        failure {
            echo 'pipeline post failure !'
        }

        success {
            echo 'pipeline post success !'
        }

        unstable {
            echo 'pipeline post unstable !'
        }

        unsuccessful {
            echo 'pipeline post unsuccessful !'
        }

        cleanup {
            echo 'pipeline post cleanup !'
        }

    }
}
