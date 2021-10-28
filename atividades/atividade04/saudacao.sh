#!/bin/bash
# Correção: 2,0
# primeira versão
#echo "Olá $(whoami)," | tee -a saudacao.log
#echo "$(date +'Hoje é dia %d, do mês %m do ano de %Y.')" | tee -a saudacao.log

# segunda versão
cat << EOF | tee -a saudacao.log
Olá $(whoami),
$(date +'Hoje é dia %d, do mês %m do ano de %Y.')
EOF
