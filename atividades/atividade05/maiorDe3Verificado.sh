#!/bin/bash
# Correção: 0,5

regex="^[+-]?[0-9]+$"

if ! [[ ${1} =~ ${regex} ]]
then
    echo "Opa!!! ${1} não é número."
    exit 1
fi

if ! [[ ${2} =~ ${regex} ]]
then
    echo "Opa!!! ${2} não é número."
    exit 1
fi

if ! [[ ${3} =~ ${regex} ]]
then
    echo "Opa!!! ${3} não é número."
    exit 1
fi

maior=${1}

if [ ${2} -gt ${maior} ]
then
    maior=${2}
fi

if [ ${3} -gt ${maior} ]
then
    maior=${3}
fi

echo ${maior}
