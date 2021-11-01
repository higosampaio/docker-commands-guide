# Publicando imagem no DockerHub

Exemplo de Dockerfile para criar uma imagem baseada no nginx e modificando a página index.html.

```docker
FROM nginx:latest

# Copiando o dir html da máquina local e sobrescrevendo o dir html do nginx
COPY html /usr/share/nginx/html

# Executando o entrypoint e o cmd que o nginx precisa para deixar a imagem rodando
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
```

Testando a imagem localmente antes de subir

```docker
# Buildando o imagem
docker build -t higosampa/nginx-fullcycle .

# Rodando a imagem
docker run --rm -d -p 8080:80 higosampa/nginx-fullcycle
```

Publicando a imagem no DockerHub

```docker
# Primeiro precisamos fazer login no DockerHub
docker login

# Subindo a imagem
docker push higosampa/nginx-fullcycle
```
