#!/bin/bash

# devem ser modificadas pelo script principal!
DBUSER=andre
DBPASSWORD=senha
IP_DBSERVER=172.31.89.2

# instala o cliente do mariadb.
yum update -y
yum install -y mariadb

# configura a senha para o usuário.
# infelizmente não é suficiente para esse user_data.
# mas funciona quando a maquina é acessada interativamente.
cat << EOF > /root/.my.cnf
[client]
user=${DBUSER}
password=${DBPASSWORD}
EOF

# arquivo criado apenas para confirmar interativamente os parâmetros passados.
cat << EOF > /root/parametros
$(date)
usuário: ${DBUSER}
senha: ${DBPASSWORD}
ip privado do servidor com banco de dados: ${IP_DBSERVER}
EOF

# só funcionou passando a senha explicitamente no comando!
mysql -h ${IP_DBSERVER} -u ${DBUSER} -p${DBPASSWORD} scripts << EOF 2> /root/erros_conexao_mariadb.log
USE scripts;
CREATE TABLE Teste ( atividade INT );
EOF
