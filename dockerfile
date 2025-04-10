FROM ubuntu:latest
WORKDIR /ashish
RUN apt-get update; apt install -y openjdk-17-jre-headless wget systemd; wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.104/bin/apache-tomcat-9.0.104.tar.gz; tar -xf /ashish/apache-tomcat-9.0.104.tar.gz; mv /ashish/apache-tomcat-9.0.104/webapps/ROOT/index.jsp /ashish/apache-tomcat-9.0.104/webapps/ROOT/index.jsp_bkp
EXPOSE 8080
COPY index.html /ashish/apache-tomcat-9.0.104/webapps/ROOT
CMD ["/ashish/apache-tomcat-9.0.104/bin/catalina.sh","run"]
