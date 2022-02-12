#!/bin/bash

ID_IMAGE=ami-08e4e35cccc6189f4

KEYNAME=${1}
DBUSER=${2}
DBPASSWORD=${3}

IP_CLIENT=$(dig myip.opendns.com @resolver1.opendns.com +short -4)


# cria o grupo de segurança
ID_SECGROUP=$(aws ec2 create-security-group --group-name andre510334 --description "grupo de seguranca criado pelo script do andre!" --output text)
aws ec2 authorize-security-group-ingress --group-id ${ID_SECGROUP} --protocol tcp --port 22 --cidr ${IP_CLIENT}/32 > /dev/null
aws ec2 authorize-security-group-ingress --group-id ${ID_SECGROUP} --protocol tcp --port 80 --cidr 0.0.0.0/0 > /dev/null
aws ec2 authorize-security-group-ingress --group-id ${ID_SECGROUP} --protocol tcp --port 3306 --source-group ${ID_SECGROUP} > /dev/null


# cria a instância do banco de dados
sed -i "s/^DBUSER=.*/DBUSER=${DBUSER}/" user_data_1.sh
sed -i "s/^DBPASSWORD=.*/DBPASSWORD=${DBPASSWORD}/" user_data_1.sh

ID_INSTANCE_1=$(aws ec2 run-instances --image-id ${ID_IMAGE} --security-group-ids ${ID_SECGROUP} --key-name ${KEYNAME} --instance-type t2.micro --user-data file://user_data_1.sh --query "Instances[0].InstanceId" --output text)

echo "Criando servidor de Banco de Dados..."

aws ec2 wait instance-status-ok --instance-ids ${ID_INSTANCE_1}

IP_DBSERVER=$(aws ec2 describe-instances --instance-ids ${ID_INSTANCE_1} --query "Reservations[].Instances[].PrivateIpAddress" --output text)
echo "IP Privado do Banco de Dados: ${IP_DBSERVER}"


# cria a instância de aplicação
sed -i "s/^DBUSER=.*/DBUSER=${DBUSER}/" user_data_2.sh
sed -i "s/^DBPASSWORD=.*/DBPASSWORD=${DBPASSWORD}/" user_data_2.sh
sed -i "s/^IP_DBSERVER=.*/IP_DBSERVER=${IP_DBSERVER}/" user_data_2.sh

ID_INSTANCE_2=$(aws ec2 run-instances --image-id ${ID_IMAGE} --security-group-ids ${ID_SECGROUP} --key-name ${KEYNAME} --instance-type t2.micro --user-data file://user_data_2.sh --query "Instances[0].InstanceId" --output text)

echo "Criando servidor de Aplicação..."

aws ec2 wait instance-status-ok --instance-ids ${ID_INSTANCE_2}

IP_DBCLIENT=$(aws ec2 describe-instances --instance-ids ${ID_INSTANCE_2} --query "Reservations[].Instances[].PublicIpAddress" --output text)

echo "IP Público do Servidor de Aplicação: ${IP_DBCLIENT}"
