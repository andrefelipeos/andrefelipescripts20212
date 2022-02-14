#!/bin/bash
# Correção: 0,5
. Como você mencionou, não estão funcionando. Mas pelo menos você tentou colocar o comando de criação do RDS, que parece que ia no caminho certo..

DBUSER=${1}
DBPASSWORD=${2}

IP_CLIENT=$(dig myip.opendns.com @resolver1.opendns.com +short -4)

ID_SECGROUP=$(aws ec2 create-security-group --group-name andre510334 --description "grupo de seguranca criado pelo script do andre!" --output text)
aws ec2 authorize-security-group-ingress --group-id ${ID_SECGROUP} --protocol tcp --port 22 --cidr ${IP_CLIENT}/32 > /dev/null
aws ec2 authorize-security-group-ingress --group-id ${ID_SECGROUP} --protocol tcp --port 80 --cidr 0.0.0.0/0 > /dev/null
aws ec2 authorize-security-group-ingress --group-id ${ID_SECGROUP} --protocol tcp --port 3306 --source-group ${ID_SECGROUP} > /dev/null

aws rds create-db-instance --db-instance-identifier mariadb-rds --db-instance-class db.t2.micro --engine mariadb --master-username ${DBUSER} --master-user-password ${DBPASSWORD} --allocated-storage 20 --no-publicly-accessible
