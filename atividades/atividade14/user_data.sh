#!/bin/bash

amazon-linux-extras install -y nginx1

mkdir /data/ && mkdir /data/html
cat << EOF > /data/html/index.html
<!DOCTYPE html>

<html>
	<head>
		<meta charset="UTF-8">
		<title>Atividade 14</title>
	</head>
	<body>
		<table>
			<tr>
				<td>Horário da última atualização</td>
				<td id="time"></td>
			</tr>
			<tr>
				<td>Tempo de atividade</td>
				<td id="uptime"></td>
			</tr>
			<tr>
				<td>Carga média (1, 5 e 15 minutos)</td>
				<td id="load_avg"></td>
			</tr>
			<tr>
				<td>Memória livre</td>
				<td id="free"></td>
			</tr>
			<tr>
				<td>Memória ocupada</td>
				<td id="used"></td>
			</tr>
			<tr>
				<td><i>Bytes</i> enviados</td>
				<td id="transmitted"></td>
			</tr>
			<tr>
				<td><i>Bytes</i> recebidos</td>
				<td id="received"></td>
			</tr>
		</table>
	</body>
</html>
EOF

sed -i "s/\/usr\/share\/nginx\/html;/\/data\/html;/" /etc/nginx/nginx.conf

systemctl start nginx.service
systemctl enable nginx.service

cat << EOF > /usr/local/bin/atualiza_index.sh
#!/bin/bash

# As saídas no Amazon Linux contém espaços em branco no início das linhas.
# (Exemplo) No Fedora, os campos para load_avg são 9, 10 e 11
# O melhor seria remover todo espaço em branco no início das linhas.
sed -i "s/<td id=\"time\">.*<\/td>/<td id=\"time\">\$(date)<\/td>/" /data/html/index.html
sed -i "s/<td id=\"uptime\">.*<\/td>/<td id=\"uptime\">\$(uptime -p)<\/td>/" /data/html/index.html
sed -i "s/<td id=\"load_avg\">.*<\/td>/<td id=\"load_avg\">\$(uptime | tr -s " " | cut -d " " -f 10,11,12)<\/td>/" /data/html/index.html
sed -i "s/<td id=\"free\">.*<\/td>/<td id=\"free\">\$(free -h | grep Mem | tr -s " " | cut -d " " -f 4)<\/td>/" /data/html/index.html
sed -i "s/<td id=\"used\">.*<\/td>/<td id=\"used\">\$(free -h | grep Mem | tr -s " " | cut -d " " -f 3)<\/td>/" /data/html/index.html
sed -i "s/<td id=\"transmitted\">.*<\/td>/<td id=\"transmitted\">\$(cat /proc/net/dev | grep eth0 | tr -s " " | cut -d " " -f 3)<\/td>/" /data/html/index.html
sed -i "s/<td id=\"received\">.*<\/td>/<td id=\"received\">\$(cat /proc/net/dev | grep eth0 | tr -s " " | cut -d " " -f 11)<\/td>/" /data/html/index.html
EOF

chmod 744 /usr/local/bin/atualiza_index.sh

echo "*/1 * * * * root /usr/local/bin/atualiza_index.sh" >> /etc/crontab
