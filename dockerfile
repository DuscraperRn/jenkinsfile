FROM ubuntu:latest
WORKDIR /ashish
RUN apt-get update
EXPOSE 8080
RUN apt install -y openjdk-17-jre-headless wget systemd
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.104/bin/apache-tomcat-9.0.104.tar.gz
RUN tar -xf /ashish/apache-tomcat-9.0.104.tar.gz
#RUN mv /ashish/apache-tomcat-9.0.104 tomcat
#COPY tomcat.service /etc/systemd/system/tomcat.service
RUN mv /ashish/apache-tomcat-9.0.104/webapps/ROOT/index.jsp /ashish/apache-tomcat-9.0.104/webapps/ROOT/index.jsp_bkp
COPY index.html /ashish/apache-tomcat-9.0.104/webapps/ROOT/
RUN cd /ashish/apache-tomcat-9.0.104/bin 
CMD ["/ashish/apache-tomcat-9.0.104/bin/catalina.sh","run"]
