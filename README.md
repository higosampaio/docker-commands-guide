# Docker Commands Guide

Executa a imagem img_teste em um container. Se não existir ele cria um container e logo finaliza o processo porque não rodamos nenhum executável que o faria ficar ativo

```js
docker run img_teste
```

Lista todos os containers ativos

```js
docker ps
```

Lista todos os containers ativos e não ativos

```js
docker ps -a
```

docker run == rodar uma imagem e cria um container
-i (modo interativo para manter o processo rodando)
-t (tty - para conseguir escrever coisas no terminal)

```js
docker run -it ubuntu bash
```

--rm (todo processo de container que subir, na hora que ele sair, o docker já remove ele)

```js
docker run -it --rm ubuntu bash
```

Levantar um container

```js
docker start container_idvs
```

Cria um container do tipo webserver nginx que só poderá ser acessado no contexto do docker, ou seja, pelos containers que estão rodando junto com o container do nginx

```js
docker run nginx
```

-p (publish - publica a porta que você quer apontar em relação a porta do container)
8080:80 (aponta a porta 8080 da máquina para a porta 80 do container nginx)

```js
docker run -p 8080:80 nginx
```

-d (detached - libera o terminal depois que subir o container)

```js
docker run -d -p 8080:80 nginx
```

Parar um container específico

```js
docker stop container_id
```
