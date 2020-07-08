//#!/usr/bin/env groovy
pipeline {
//     agent { docker 'maven:3-alpine' }
    agent any
    options {
        retry(3)
        timeout(time: 1, unit: 'HOURS')
        timestamps()
    }
    environment {
        CC = 'clang'
    }
    parameters {
        string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')

        text(name: 'BIOGRAPHY', defaultValue: '', description: 'Enter some information about the person')

        booleanParam(name: 'TOGGLE', defaultValue: true, description: 'Toggle this value')

        choice(name: 'CHOICE', choices: ['One', 'Two', 'Three'], description: 'Pick something')

        password(name: 'PASSWORD', defaultValue: 'SECRET', description: 'Enter a password')
    }

    triggers {
        // 每五分钟 详情查看https://blog.csdn.net/nklinsirui/article/details/95338535
        cron('H/5 * * * *')
    }

    tools {
        maven "Maven"
        jdk "JDK8"
    }
    stages {
        stage('Agent Check') {
            agent { docker 'openjdk:8-jre' }
            steps {
                echo 'agent in stage'
                echo 'jre check'
                sh 'java -version'
            }
            options {
                skipDefaultCheckout()
            }
        }

        stage('Env Check') {
            environment {
                AN_ACCESS_KEY = credentials('github')
                APP_PROCESS_ID = sh(script: 'jps | grep jenkins-demo | awk \'{print $1}\'', returnStdout: true).trim() as Integer
            }
            steps {
                sh 'printenv'
                // 打印环境变量时用单引号包裹
                sh 'echo "AN_ACCESS_KEY is $AN_ACCESS_KEY"'
                sh 'echo "AN_ACCESS_KEY_USR is $AN_ACCESS_KEY_USR"'
                sh 'echo "AN_ACCESS_KEY_PSW is $AN_ACCESS_KEY_PSW"'
                sh 'echo "AN_ACCESS_KEY_PSW is $APP_PROCESS_ID"'
            }
        }

        stage('Parameters') {
            steps {
                // 打印参数时使用双引号包裹
                echo "Hello ${params.PERSON}"

                echo "Biography: ${params.BIOGRAPHY}"

                echo "Toggle: ${params.TOGGLE}"

                echo "Choice: ${params.CHOICE}"

                echo "Password: ${params.PASSWORD}"
            }
        }

        stage('Build') {
            steps {
                echo "hello, ${PERSON}, let's begin build"
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
