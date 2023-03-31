FROM openjdk:8-jdk-alpine
ARG JAR_FILE=target/*.jar


COPY ${JAR_FILE} tpachatproject-1.1.jar
ENTRYPOINT ["java", "-jar" ,"/tpachatproject-1.0.jar"]
EXPOSE 8089
