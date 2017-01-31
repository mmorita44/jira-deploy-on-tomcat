Atlassian JIRA war file deploying tools
=========================

[![licence badge]][licence]

# Preparation

You need to a jira-application.properties file insert into a WAR file of Atlassian JIRA.

```
$ echo "jira.home = /var/atlassian/application-data/jira" > WEB-INF/classes/jira-application.properties
$ jar uf jira.war WEB-INF
```

# File Construction

```
.
├── docker-compose.yml
├── Dockerfile
├── jira.war
└── server.xml
```

`jira.war` is a WAR file of Atlassian JIRA. 

`server.xml` is a tomcat configuration file.

# Usage

Run `docker-command`.

# Reference

- [Installing JIRA on Tomcat 6.0 or 7.0 - Atlassian Documentation](https://confluence.atlassian.com/jira064/installing-jira-on-tomcat-6-0-or-7-0-720411825.html)

[licence]: <LICENSE>
[licence badge]: http://img.shields.io/badge/license-MIT-blue.svg?style=flat
