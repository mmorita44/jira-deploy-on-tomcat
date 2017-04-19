FROM mmorita44/tomcat:8.5.6-jre8-alpine
MAINTAINER Masato Morita <m.morita44@hotmail.com>

# copy files.
COPY server.xml /usr/local/tomcat/conf/server.xml
COPY jira.war /usr/local/tomcat/jira.war

# install packages.
RUN apk add --no-cache curl unzip tar

# set jira dependency libraries.
RUN curl -Ls https://downloads.atlassian.com/software/jira/downloads/jira-jars-tomcat-distribution-6.4-m13-2-tomcat-7x.zip -o /tmp/jira-jars-tomcat.zip && \
    unzip -qd /usr/local/tomcat/lib /tmp/jira-jars-tomcat.zip && \
# set mysql driver.
    curl -Ls "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.38.tar.gz" | tar -xz --directory "/usr/local/tomcat/lib" --strip-components=1 --no-same-owner "mysql-connector-java-5.1.38/mysql-connector-java-5.1.38-bin.jar" && \
# delete unused files.
    rm -rf /tmp/* && \
    apk del curl unzip tar

EXPOSE 8080

VOLUME /var/shdsd/application-data/jira

CMD ["catalina.sh", "run"]
