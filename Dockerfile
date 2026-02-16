FROM tomcat:9-jdk17

RUN rm -rf /usr/local/tomcat/webapps/*

COPY target/JenkinsDemo-0.0.1-SNAPSHOT.jar /usr/local/tomcat/webapps/ROOT.jar

EXPOSE 8080

CMD ["catalina.sh", "run"]
