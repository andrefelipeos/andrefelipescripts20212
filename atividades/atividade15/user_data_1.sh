#!/bin/bash

# devem ser modificadas pelo script principal!
DBUSER=
DBPASSWORD=


# instala, inicia e habilita o mariadb
yum update -y
yum install -y mariadb-server

systemctl start mariadb.service
systemctl enable mariadb.service


# configura o mariadb para permitir conexoes externas
# um alternativa é adicionar no arquivo /root/.my.cnf
#cat << EOF >> /etc/my.cnf
#[mysqld]
#skip-networking=0
#skip=bind-address
#EOF

# reinicia o servico mariadb para aplicar as configuracoes
#systemctl restart mariadb.service


# criar banco, tabela e usuario
mysql << EOF 2> /root/errors_mariadb_config.log
CREATE DATABASE scripts;
CREATE USER '${DBUSER}'@'%' IDENTIFIED BY '${DBPASSWORD}';
GRANT ALL PRIVILEGES ON scripts.* TO '${DBUSER}'@'%';
USE scripts;
CREATE TABLE teste01 ( campo INT );
EOF
