#!/bin/bash

comando=${1}
nome=${2}
email=${3}
arquivo="agenda.db"

if [ ${comando} == "adicionar" ]
then
    if [ ! -f ${arquivo} ]
    then
        echo "Arquivo criado!!!"
    fi

    echo "${nome}:${email}" >> ${arquivo}
    echo "Usuário ${nome} adicionado."
fi


if [ ${comando} == "listar" ]
then
    cat ${arquivo}
fi


if [ ${comando} == "remover" ]
then
    sed -i /"${nome}"/d ${arquivo}
    echo "Usuário ${nome} removido."
fi
