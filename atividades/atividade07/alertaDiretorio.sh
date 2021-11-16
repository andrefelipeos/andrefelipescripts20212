#!/bin/bash

intervalo=${1}
diretorio=${2}

TMP=".tmp"
LOG="dirSensors.log"

if [ -f ${LOG} ]
then
    rm ${LOG}
fi

$(ls ${diretorio} > ${TMP})

while true
do
    sleep ${intervalo}

    if [ $(ls ${diretorio} | wc -l) -ne $(wc -l ${TMP} | cut -d" " -f1) ]
    then
	echo "[$(date +"%d-%m-%y %H:%M:%S")] Alteração! $(wc -l ${TMP} | cut -d" " -f1)->$(ls ${diretorio} | wc -l)." >> ${LOG}
	echo $(cat ${TMP})
	$(ls ${diretorio} > ${TMP})
    fi
done
