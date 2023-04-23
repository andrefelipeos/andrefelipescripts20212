# andrefelipescripts20212
Repositório para atividades da disciplina Programação de Scripts 2021.2.

As atividades desse repositório são divididas da seguinte maneira:
- Atividades 01 a 07: são códigos *shellscript* que executam tarefas locais, no hospedeiro GNU/Linux em que são executados.
- Atividades 13 a 17: são códigos *shellscript* que executam tarefas na nuvem AWS, criando e executando instâncias e serviços.

Cabem alguns destaques sobre as atividades que utilizam a nuvem AWS:
- A atividade 14 é uma refatoração da atividade 13, utilizando o CRON para
agendar a execução regular de um *script* simples, dentro de uma instância EC2.
- As atividades 15 e 16, juntas, correspondem a criar duas instâncias EC2:
    - A primeira executando um servidor do banco de dados MariaDB.
    - A segunda, que se conecta ao servidor MariaDB da primeira, executando o servidor web NGINX.
- A atividade 17 está incorreta ou incompleta. Ela seria uma refatoração das atividades 15 e 16,
onde a instância EC2 com o servidor MariaDB seria substituída por uma instância RDS.
