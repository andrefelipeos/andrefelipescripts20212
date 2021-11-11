#!/bin/bash
# Correção: 1,0

ARQUIVO=${1}
TEMP="medias_ping"

if [ -f ${TEMP} ]
then
    rm ${TEMP}
fi

for ip in $(cat ${ARQUIVO})
do
    echo "${ip} $(ping -c 10 ${ip} | tail --lines=1 | cut --delimiter="/" --fields=5)ms" >> ${TEMP}
done

cat ${TEMP} | sort --numeric-sort --key=2
rm ${TEMP}
