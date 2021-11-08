#!/bin/bash
# Correção: 1,5

arquivo="agenda.db"

comando=${1}


if [ ${comando} = "adicionar" ]
then
    nome=${2}
    email=${3}

    if [ ! -f ${arquivo} ]
    then
        touch ${arquivo}
        echo "Arquivo criado!!!"
    else
        if [ $(grep ":${email}$" ${arquivo} | wc -l) -gt 0 ]
        then
            echo "E-mail já cadastrado!!!"
	    exit 2
        fi
    fi

    echo "${nome}:${email}" >> ${arquivo}
    echo "Usuário ${nome} adicionado."
fi


if [ ${comando} = "listar" ]
then
    if [ ! -f ${arquivo} ]
    then
        echo "Arquivo não existe!!!"
	exit 1
    elif [ ! -s ${arquivo} ]
    then
        echo "Arquivo vazio!!!"
    fi

    cat ${arquivo}
fi


if [ ${comando} = "remover" ]
then
    email=${2}

    if [ ! -f ${arquivo} ]
    then
        echo "Arquivo não existe!!!"
	exit 1
    fi

    if [ $(grep ":${email}$" ${arquivo} | wc -l) -eq 0 ]
    then
        echo "E-mail não cadastrado."
	exit 2
    fi

    nome=$(grep ":${email}$" ${arquivo} | cut -d":" -f1)

    sed -i /":${email}$"/d ${arquivo}
    echo "Usuário ${nome} removido."

    if [ ! -s ${arquivo} ]
    then
        rm ${arquivo}
        echo "Arquivo vazio removido."
    fi
fi
