#!/bin/bash
# 1. mensagens que não são do sshd
grep -v "sshd" /home/compartilhado/auth.log

# 2. mensagens que indicam um login de sucesso via sshd cujo nome de usuário começa com j
grep "sshd.*session opened.*user j" /home/compartilhado/auth.log

# 3. todas as vezes que alguém tentou fazer login via root através do sshd
grep "sshd.*user root" /home/compartilhado/auth.log

# 4. todas as vezes que alguém conseguiu fazer login com sucesso nos dias 11 e 12
grep "Oct 1[12].*session opened for user" /home/compartilhado/auth.log
