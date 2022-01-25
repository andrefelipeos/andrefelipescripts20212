#!/bin/bash

KEYNAME=${1}
IMAGEID=ami-08e4e35cccc6189f4

SECGROUP=$(aws ec2 create-security-group --group-name andre510334 --description "grupo de seguranca criado pelo script do andre!" --output text)
aws ec2 authorize-security-group-ingress --group-id ${SECGROUP} --protocol tcp --port 22 --cidr 0.0.0.0/0 > /dev/null
aws ec2 authorize-security-group-ingress --group-id ${SECGROUP} --protocol tcp --port 80 --cidr 0.0.0.0/0 > /dev/null

INSTANCE=$(aws ec2 run-instances --image-id ${IMAGEID} --security-group-ids ${SECGROUP} --key-name ${KEYNAME} --instance-type t2.micro --user-data file://user_data --query "Instances[0].InstanceId" --output text)
echo "Criando servidor de Monitoramento em CRON..."

while [ _running != _$(aws ec2 describe-instance-status --instance-ids ${INSTANCE} --query "InstanceStatuses[].InstanceState.Name" --output text) ]
do
	sleep 5
done
echo "Instância em estado \"running\""

PUBLICIP=$(aws ec2 describe-instances --instance-ids ${INSTANCE} --query "Reservations[].Instances[].PublicIpAddress" --output text)
echo "Acesse: http://${PUBLICIP}/"
