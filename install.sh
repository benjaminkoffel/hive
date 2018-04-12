secret=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 64 | head -n 1)

apt-get update
apt-get install -y dirmngr apt-transport-https git --install-recommends

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key D88E42B4
echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" > /etc/apt/sources.list.d/elastic-5.x.list

apt-key adv --keyserver hkp://pgp.mit.edu --recv-key 562CBC1C
echo 'deb https://dl.bintray.com/cert-bdf/debian any main' > /etc/apt/sources.list.d/thehive-project.list

apt-get update
apt-get install -y elasticsearch thehive cortex 

cp elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
echo "play.crypto.secret=\"$secret\"" >> /etc/thehive/application.conf
echo "play.http.secret.key=\"$secret\"" >> /etc/cortex/application.conf
cd /opt/
git clone https://github.com/TheHive-Project/Cortex-Analyzers.git

# service elasticsearch start
# service thehive start
# service cortex start

echo "MANUAL:"
echo "- open cortex http://localhost:9001"
echo "- create organization, user and API key'"
echo "- edit /etc/thehive/application.conf with API key"
echo "- edit /etc/cortex/application.conf with /opt/Cortex-Analyzers/analyzers"
