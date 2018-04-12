apt-get update
apt-get install -y dirmngr apt-transport-https --install-recommends

echo 'deb https://dl.bintray.com/cert-bdf/debian any main' | tee -a /etc/apt/sources.list.d/thehive-project.list
apt-key adv --keyserver hkp://pgp.mit.edu --recv-key 562CBC1C

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key D88E42B4
echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-5.x.list

apt-get update
apt-get install thehive cortex elasticsearch

cp elasticsearch.yml /etc/elasticsearch/elasticsearch.yml

systemctl enable elasticsearch.service
systemctl start elasticsearch.service
systemctl status elasticsearch.service
