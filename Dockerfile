# Iniciar um Dockerfile com uma imagem base para gerar o container
FROM nginx:latest

# Definir o ponto de partida ao montar o container, você cairá no dir especificado
WORKDIR /app

# Comandos que serão executados ao montar o container
RUN apt-get update && \
    apt-get install vim -y

# Copia arquivos da máquina para o container 
# O dir html está sendo copiado para dentro do container nginx e está fazendo um replace no dir html que já existia 
COPY html /usr/share/nginx/html

