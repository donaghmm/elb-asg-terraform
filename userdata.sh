#!/bin/bash -v
apt-get update -y
apt-get install -y apache2 tomcat8

#Configuring AJP on apache
cp /etc/apache2/mods-available/proxy.load /etc/apache2/mods-enabled/
cp /etc/apache2/mods-available/proxy_ajp.load /etc/apache2/mods-enabled/

cat > /etc/apache2/mods-enabled/proxy_ajp.conf <<- "EOF"
<IfModule mod_proxy_ajp.c>

    ProxyRequests Off
    <Proxy *>
        Order deny,allow
        Deny from all
        Allow from localhost
    </Proxy>
    ProxyPass       / ajp://localhost:80/
    ProxyPassReverse    / ajp://localhost:80/

</IfModule>
EOF

# Enabling AJP on tomcat
# comment the existing Connector and uncomment the AJP Connector on port 80
sed -i -e '/Define an AJP 1.3 Connector on port 8009/{n;d}' /etc/tomcat8/server.xml
sed -i -e '/Connector port="8009"/{n;N;d}' /etc/tomcat8/server.xml
sed -i -e 's/8009/80/g' /etc/tomcat8/server.xml
sed -i -e '/Connector port="8080"/i <!--' /etc/tomcat8/server.xml
sed -i -e '/redirectPort="8443"/a -->' /etc/tomcat8/server.xml

#restart apache and tomcat
service apache2 restart
service tomcat8 restart
