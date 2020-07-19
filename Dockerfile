FROM openjdk:8-jre

ARG JAR_FILE
ADD target/${JAR_FILE} /app/jenkins-demo.jar

EXPOSE 8888

ENTRYPOINT ["java", "-jar", "/app/jenkins-demo.jar"]
