FROM mmorita44/tomcat:8.5.6-jre8-alpine
MAINTAINER Masato Morita <m.morita44@hotmail.com>

# Copy files
COPY server.xml /usr/local/tomcat/conf/server.xml
COPY jira.war /usr/local/tomcat/jira.war

# Define valiables
ARG MYSQL_VERSION=5.1.38
ARG JTDS__VERSION=1.2.4
ARG POSTGRESQL_VERSION=9.4.1212

# Install the packages
RUN apk add --no-cache curl unzip tar

# Add the libraries required to run JIRA
RUN curl -Ls https://downloads.atlassian.com/software/jira/downloads/jira-jars-tomcat-distribution-6.4-m13-2-tomcat-7x.zip -o /tmp/jira-jars-tomcat.zip && \
    unzip -qd /usr/local/tomcat/lib /tmp/jira-jars-tomcat.zip && \
# Add the MySQL driver
    curl -Ls https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MYSQL_VERSION}.tar.gz | tar -xz --directory /usr/local/tomcat/lib --strip-components=1 --no-same-owner mysql-connector-java-${MYSQL_VERSION}/mysql-connector-java-${MYSQL_VERSION}-bin.jar && \
# Add the SQL Server driver
    curl -Ls https://sourceforge.net/projects/jtds/files/jtds/${JTDS__VERSION}/jtds-${JTDS__VERSION}-dist.zip -o /tmp/jtds-${JTDS__VERSION}-dist.zip && \
    unzip -qd /usr/local/tomcat/lib /tmp/jtds-${JTDS__VERSION}-dist.zip jtds-${JTDS__VERSION}.jar && \
# Add the PostgreSQL driver
    curl -Ls https://jdbc.postgresql.org/download/postgresql-${POSTGRESQL_VERSION}.jar -o /usr/local/tomcat/lib/postgresql-${POSTGRESQL_VERSION}.jar && \
# Manually download the Oracle Database JDBC Drivers and add it to Tomcat if you use

# Delete unused files
    rm -rf /tmp/* && \
    apk del curl unzip tar

# Expose default HTTP connector port
EXPOSE 8080

# Set Volume mount point for home directory
VOLUME /var/atlassian/application-data/jira

# Run JIRA as a foreground process by default
CMD ["catalina.sh", "run"]
