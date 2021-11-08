# Utilizando nginx como proxy reverso

### 1. Criando imagem nginx

Acesse o dir no qual o Dockerfile está inserido e rode o comando:

```docker
docker build -t  higosampaio/nginx:prod . -f Dockerfile.prod
```

### 2. Criando imagem laravel

Acesse o dir no qual o Dockerfile está inserido e rode o comando:

```docker
docker build -t higosampaio/laravel:prod . -f Dockerfile.prod
```

### 3. Criando uma network para os containers trabalharem em uma mesma rede

```docker
docker network create laranet
```

### 3. Levantando a imagem do laravel na network criada

```docker
docker run -d --network laranet --name laravel higosampa/laravel:prod
```

### 4. Levantando a imagem do nginx na network

```docker
docker run -d --network laranet --name nginx -p 8080:80 higosampaio/nginx:prod
```

### 5. Acessando o nginx

```
localhost:8080
```

Obs. Caso o projeto em laravel tenha imagens, será preciso copiar os arquivos pra dentro do nginx porque o php-fpm não vai servir as imagens.
