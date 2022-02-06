#!/bin/bash

# devem ser modificadas pelo script principal!
DBUSER=
DBPASSWORD=
IP_DBSERVER=


# instala o cliente mariadb
yum update -y
yum install -y mariadb

cat << EOF > /root/.my.nf
[client]
user=${DBUSER}
password=${DBPASSWORD}
EOF

mysql -u ${DBUSER} scripts -h ${IP_DBSERVER} << EOF 2> /root/errors_mariadb_connection.log
USE scripts;
CREATE TABLE Teste ( atividade INT );
EOF

# se conecta ao banco e cria a tabela
#mysql << EOF 2> /root/errors_mariadb_config.log
#CREATE DATABASE scripts;
#CREATE USER '${DBUSER}'@'%' IDENTIFIED BY '${DBPASSWORD}';
#GRANT ALL PRIVILEGES ON scripts.* TO '${DBUSER}'@'%';
#EOF
