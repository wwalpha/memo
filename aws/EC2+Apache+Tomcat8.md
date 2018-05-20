* sudo su root
* yum -y install java-1.8.0-openjdk-devel tomcat8 httpd24
* alternatives --config java
  * select number2
  * `java -version` -> 1.8
* aws s3 cp s3://elasticbeanstalk-ap-northeast-1-562849865336/2018112BEF-StudySite-2.0.1.war /tmp/ROOT.war
* mv /tmp/ROOT.war /var/lib/tomcat8/webapps/ROOT.war
* vi /etc/httpd/conf.modules.d/httpd-proxy.conf
  * ProxyPass / ajp://localhost:8009/
* service httpd start
* service tomcat8 start
* auto start
  * chkconfig --list httpd
  * chkconfig --list tomcat8
* vi /usr/share/tomcat8/conf/tomcat8.conf
```
#JAVA_OPTS="-Djava.library.path=/usr/lib"
↓
JAVA_OPTS="-DRDS_DB_HOST=demo-rds-az01.cinlbecofvo4.ap-northeast-1.rds.amazonaws.com -DRDS_DB_NAME=StudySite -DRDS_DB_PORT=3306 -DRDS_DB_USER=wwalpha -DRDS_DB_PSW=session10"
```
* service tomcat8 restart
* cd /var/log/tomcat8
* tail -100 catalina.out > log1
* vi log1
