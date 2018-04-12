apt-get update
apt-get install -y dirmngr apt-transport-https git python-pip python3-pip --install-recommends

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key D88E42B4
echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" > /etc/apt/sources.list.d/elastic-5.x.list

apt-key adv --keyserver hkp://pgp.mit.edu --recv-key 562CBC1C
echo "deb https://dl.bintray.com/cert-bdf/debian any main" > /etc/apt/sources.list.d/thehive-project.list

apt-get update
apt-get install -y elasticsearch thehive cortex 

cp elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
cp thehive.conf /etc/thehive/application.conf
cp cortex.conf /etc/cortex/application.conf

secret=$(cat /dev/urandom | tr -dc "a-zA-Z0-9" | fold -w 64 | head -n 1)
sed -i -e "s/\[SECRET\]/$secret/g" /etc/thehive/application.conf
sed -i -e "s/\[SECRET\]/$secret/g" /etc/cortex/application.conf

cd /opt/
git clone https://github.com/TheHive-Project/Cortex-Analyzers.git
cd /opt/Cortex-Analyzers/analyzers
find . -type d -execdir python2 -m pip install -r {}/requirements.txt ";"
find . -type d -execdir python3 -m pip install -r {}/requirements.txt ";"

service elasticsearch start
service thehive start
service cortex start

echo "MANUAL:"
echo "- open cortex http://localhost:9001"
echo "- create organization, user and API key"
echo "- update /etc/thehive/application.conf with API key"
echo "- service thehive restart"
