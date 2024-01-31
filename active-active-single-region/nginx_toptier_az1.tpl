#!/bin/bash

# Lets update Ubuntu
sudo apt update -y

# Lets make sure openssl is installed
sudo apt install openssl

# Install wget
sudo apt install wget

# Lets create the directory for the config file and certs
mkdir /etc/ssl/nginxsccademo/

# Lets create the cert config file for use in our openssl command to eliminate the cert prompts
cat > /etc/ssl/nginxsccademo/certconfig.conf << EOF
[req]
prompt = no
distinguished_name = req_distinguished_name
req_extensions = v3_req

[req_distinguished_name]
C = US
ST = Virginia
L = Washington D.C.
O = F5 
OU = DoD Engineering
CN = ngnixsccademo.com
emailAddress = dontspamme@example.com

[v3_req]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = nginxsccademo.com
DNS.2 = www.nginxsccademo.com
EOF

# Create the self-signed SSL cert
cd /etc/ssl/nginxsccademo/
sudo openssl req -x509 -nodes -days 365 -config certconfig.conf -newkey rsa:2048 -keyout /etc/ssl/nginxsccademo/nginxsccademo.key -out /etc/ssl/nginxsccademo/nginxsccademo.crt

cd /etc/nginx/
sudo wget https://raw.githubusercontent.com/therealnoof/nginx-scca-aws-terraform/main/active-active-single-region/nginx-confs/nginx-toptier-az1/nginx.conf -O nginx.conf
sudo systemctl reload nginx