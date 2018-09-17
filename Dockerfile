FROM debian:jessie
MAINTAINER kunal

ENV CATALINA_HOME /opt/tomcat/
ENV PATH $CATALINA_HOME/bin:$PATH
ENV JAVA_URL http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-i586.tar.gz
ENV JAVA_HOME /opt/java


RUN apt-get update && apt-get upgrade -y \
    && apt-get install wget -y

# Installing JAVA
RUN mkdir -p "$JAVA_HOME"
RUN echo $JAVA_HOME
RUN cd $JAVA_HOME && wget --no-check-certificate -c --header  "Cookie: oraclelicense=accept-securebackup-cookie" $JAVA_URL \
    && tar -xvf jdk-8u181-linux-i586.tar.gz  --strip-components=1


RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME

ENV TOMCAT_MAJOR 8
ENV TOMCAT_VERSION 8.5.34
ENV TOMCAT_TGZ_URL http://mirrors.fibergrid.in/apache/tomcat/tomcat-8/v8.5.34/bin/apache-tomcat-8.5.34.tar.gz
RUN mkdir -p /opt/tomcat && cd /opt/tomcat \
    && wget -q $TOMCAT_TGZ_URL  \
#    && wget -q $TOMCAT_TGZ_URL.asc \
    && tar -xvf apache-tomcat-8.5.34.tar.gz --strip-components=1 \
    && rm bin/*.bat \
    && rm apache-tomcat-8.5.34.tar.gz
# add data below to show over browser
ADD ./target/*.war $CATALINA_HOME/webapps/

EXPOSE 8080
