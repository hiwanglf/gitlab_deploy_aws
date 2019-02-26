#!/bin/bash

sudo su  -
sudo sed -i '/^external_url*/d' /etc/gitlab/gitlab.rb
sudo cat >>/etc/gitlab/gitlab.rb<<EOF 
external_url 'https://gitlab.hiwanglf.com'
EOF

# postgresql
sudo cat >> /etc/gitlab/gitlab.rb <<EOF
postgresql['enable'] = false
gitlab_rails['db_adapter'] = "postgresql"
gitlab_rails['db_encoding'] = "unicode"
gitlab_rails['db_database'] = "gitlabhq_production"
gitlab_rails['db_username'] = "gitlab"
gitlab_rails['db_password'] = "xx745133483"
gitlab_rails['db_host'] = "gitlab-db-ha.czdy1f6lqkys.ap-northeast-2.rds.amazonaws.com"
EOF

# redis
sudo cat >> /etc/gitlab/gitlab.rb <<EOF
redis['enable'] = false
gitlab_rails['redis_host'] = "gitlab-redis.q4ljue.ng.0001.apn2.cache.amazonaws.com"
gitlab_rails['redis_port'] = 6379
EOF

sudo gitlab-ctl reconfigure
# create file storage gitfile
sudo mkdir /data
sudo cat >> /etc/gitlab/gitlab.rb <<EOF
git_data_dirs({
   "default" => { "path" => "/data" }
})
EOF

nginx['redirect_http_to_https'] = true
registry_nginx['redirect_http_to_https'] = true
mattermost_nginx['redirect_http_to_https'] = true

sudo mkdir -p /etc/gitlab/ssl
sudo chmod 700 /etc/gitlab/ssl
sudo cat > /etc/gitlab/ssl/gitlab.hiwanglf.com.key << EOF
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEA6E/Hr9ArJp14qJDykKRuVtN0T4sFHdA+WR+DEkqdubh40TwI
gfDHIOotvTMSUImGD35C+nWMic7XwAFDiWif2APEKT33rbuNcADJ0pXNgrueHU7J
+WMLXhnVrAuyxQuBEhVRuWPJ4VT7ytoEprZ401QO1T5WeJm4wR2iJvNjj3GqCMcW
cOktIyU1Rc+0VzTLRIkxVwaLZHAooMIn0HRTgpv+2YHToZIw37eLZjDd00e81Iqs
HEWVkY3J+s0Y2PbCFR06ZOCj0aLjwq2mrk1/Ubv7LbhdbnAN+QxYJGwNPqhnpK+W
Qjz6tuK23cc9eGPasQPTqIMXPOpMf/WK6BSmlQIDAQABAoIBAElUfZTqoeRTirWy
405zCP1RTAKbwGazyCp7vvT0JqtsJn7tc0YJCeJC6WMyjtJrRqz3Tw8eMdmCOCo8
e+QQ6XvXXIEkNV1auX+kUBCwBqoArR1VNH4LHJh8kSz4mFqIkhpyLlTVwfDl0YEr
ppI1QRh8DR6UydjRtTcIMpoW89NgFImTg9QkHFcTXZzspY4tjTRnli7MBHhl5tKP
VYXhpL5mFWy132VRM60sHN3PuRFJXHIMLKf7o9dPpWcy//+YMzUFThGJ0PGseAvj
U7KMKPhAnhUXN5+uC+QKJwlFcFSZW7/fOlgkZAZNVtEcLhPAM2cgTowJIvlnmxAx
RAWT6UECgYEA/7O/obHlM+D5aYRhCsFO2nkD/LhbuLCJ8k8fkC56wPxyuTyfO8D5
UI5d3lJRCrQkZGMqbPVffnpA3wCcQy7laRJuDsHVLORune9vk1jjXNaNoOyTBOc+
Ov3qaUtMltABH7e9+EHgHZNUp7V7M5cQxa03LPQg3s8BoGo90FOlfTECgYEA6JUO
awk9tYc6DkE8vG9JgSYk+7cUnOqK1UG05/r8UwDJVNL8Dz5Ubj257YCeKjQuuKpK
/YBETXq6F80am1ipv0+suBgc62sD0OcJqRWJeVXs32mIrs6tHuzAmnIoXXi31ZQU
bNf5arlizrDd3+4Xjot+eHFjx5A3pKZmtSME1qUCgYEAz0Rhqmzr8FCFe22Nx80H
4PnFLJ434w5e0yYl3JaAdFxtlg84t5Plw9GS7zpkbLu24BSt+CIxpPDuEpWJFMA3
vyLsSVP/O2Ny8tx54cNkkQVtSitZxNi4zdKyp2UdEQZMUux6tXiYdQDO1x65Xgku
1D1jAzJkTpcXp3NW5b5X35ECgYEAnSPwXOMefWKDGBR9q7bpC8gw3p0A4VAaQyGk
z8Ok7ZOvc48lXEs5kk5EK7JlqpAdLQlpp0MdYtfTmbcrDeBmt+pmAO/RwkFIj8E5
prL1cjRa2UudXLYpA6bkLrWIjja8xiHJdwyo6LGej5WyItTjt5yJ82hxCOlonucK
p8GkSD0CgYAmz7vQvm8hH5ErZNQ8ybMRjRGoicmcclZAZxEh7rTG+XFYdGFbhWp7
yM0z4EGN2Sd9VygOiXQjma5ZPWECkcCwJSAGj+/OCb6H6PFsDTNH4mR0d0H8lbTu
cjk8bmdKvlc0DDFFbmCNncca3MgAA0dBQI0DuAlotBxcioie+SXaGA==
-----END RSA PRIVATE KEY-----
EOF

sudo cat > /etc/gitlab/ssl/gitlab.hiwanglf.com.crt << EOF
-----BEGIN CERTIFICATE-----
MIIDiDCCAnACCQD81t2yaQPEhTANBgkqhkiG9w0BAQsFADCBhTELMAkGA1UEBhMC
Q04xEDAOBgNVBAgMB1NoYWFueGkxDjAMBgNVBAcMBVhpJ2FuMRUwEwYDVQQKDAxo
aXdhbmdsZiBMdGQxHDAaBgNVBAMME2dpdGxhYi5oaXdhbmdsZi5jb20xHzAdBgkq
hkiG9w0BCQEWEGhpd2FuZ2xmQDE2My5jb20wHhcNMTkwMjI1MDc1ODQ2WhcNMjAw
MjI1MDc1ODQ2WjCBhTELMAkGA1UEBhMCQ04xEDAOBgNVBAgMB1NoYWFueGkxDjAM
BgNVBAcMBVhpJ2FuMRUwEwYDVQQKDAxoaXdhbmdsZiBMdGQxHDAaBgNVBAMME2dp
dGxhYi5oaXdhbmdsZi5jb20xHzAdBgkqhkiG9w0BCQEWEGhpd2FuZ2xmQDE2My5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDoT8ev0CsmnXiokPKQ
pG5W03RPiwUd0D5ZH4MSSp25uHjRPAiB8Mcg6i29MxJQiYYPfkL6dYyJztfAAUOJ
aJ/YA8QpPfetu41wAMnSlc2Cu54dTsn5YwteGdWsC7LFC4ESFVG5Y8nhVPvK2gSm
tnjTVA7VPlZ4mbjBHaIm82OPcaoIxxZw6S0jJTVFz7RXNMtEiTFXBotkcCigwifQ
dFOCm/7ZgdOhkjDft4tmMN3TR7zUiqwcRZWRjcn6zRjY9sIVHTpk4KPRouPCraau
TX9Ru/stuF1ucA35DFgkbA0+qGekr5ZCPPq24rbdxz14Y9qxA9Oogxc86kx/9Yro
FKaVAgMBAAEwDQYJKoZIhvcNAQELBQADggEBANc5ZiwX5MteTeLGffH0xWUZbaL3
A5SjEzsU6wzsVzRSL8WtUyHrFevxr8YC3SvzH3VG4IR4U2/6lTK3MsrT5B48adC7
hno6V4ZWcnBK4p0r8tg0P04p7LVhUs2zhd0Ie29BM9oio2QhrWm8XEX7ZhtRlfum
GmrDXjTJJT251d9xi/pK3mYeQ5o03zeOS11bUXBa2rEgTaJ2iber/N83JuqwdZ54
TTXi4dFwtj1lGGc5x98v0ycvz2QJdGMEyN+zB6gyuK4YlLCwgWA0vDDJfH3Vp21M
lIUxQfvMZDmntz9Z+AK3LXmPoiCD0XyPjiW9HrtqBLzsKuDLVnvweZmpfUU=
-----END CERTIFICATE-----
EOF


sudo gitlab-ctl reconfigure