#!/bin/bash
# Correção: 1,0

intervalo=${1}
diretorio=${2}

TMP=".tmp"
LOG="dirSensors.log"

if [ -f ${LOG} ]
then
    rm ${LOG}
fi

ls ${diretorio} > ${TMP}
qtd=$(wc -l ${TMP} | cut -d" " -f1)

while true
do
    sleep ${intervalo}

    qtd_atual=$(ls ${diretorio} | wc -l)

    if [ ${qtd} -ne ${qtd_atual} ]
    then
	horario="[$(date +"%d-%m-%y %H:%M:%S")]"
	alteracao="Alteração! ${qtd}->${qtd_atual}."

	echo $(ls ${diretorio} | diff ${TMP} - | grep ">" | cut -d" " -f2) > .inseridos
	echo $(ls ${diretorio} | diff ${TMP} - | grep "<" | cut -d" " -f2) > .removidos

	echo "${horario} ${alteracao} Adicionados: $(cat .inseridos) | Removidos: $(cat .removidos)" | tee -a ${LOG}
	ls ${diretorio} > ${TMP}
	qtd=${qtd_atual}
    fi
done
