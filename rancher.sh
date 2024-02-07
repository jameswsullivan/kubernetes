# "Command":
# Tomcat
sh -c 'apt-get -y update && apt-get -y install nano iputils-ping procps screen && catalina.sh run'

# Solr
sh -c 'apt-get -y update && apt-get -y install nano iputils-ping procps screen && chown -R solr:0 /var/solr && su -m solr -c "export PATH=/opt/solr/bin:/opt/solr/docker/scripts:/opt/solr/prometheus-exporter/bin:/opt/java/openjdk/bin:$PATH && docker-entrypoint.sh solr-foreground"'