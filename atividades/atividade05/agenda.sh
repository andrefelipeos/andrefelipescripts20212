#!/bin/bash

arquivo="agenda.db"

comando=${1}

if [ ${comando} == "adicionar" ]
then
    nome=${2}
    email=${3}

    if [ ! -f ${arquivo} ]
    then
        echo "Arquivo criado!!!"
    fi

    echo "${nome}:${email}" >> ${arquivo}
    echo "Usuário ${nome} adicionado."
fi


if [ ${comando} == "listar" ]
then
    if [ ! -f ${arquivo} ]
    then
        echo "Arquivo vazio!!!"
	exit 2
    fi

    cat ${arquivo}
fi


if [ ${comando} == "remover" ]
then
    email=${2}

    if [ $(grep ":${email}$" ${arquivo} | wc -l) -eq 0 ]
    then
        echo "E-mail não cadastrado."
	exit 2
    fi

    nome=$(grep ":${email}$" ${arquivo} | cut -d":" -f1)

    sed -i /":${email}$"/d ${arquivo}
    echo "Usuário ${nome} removido."
fi
