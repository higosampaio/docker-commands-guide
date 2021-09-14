# Docker Commands Guide

Executa a imagem img_teste em um container. Se não existir ele cria um container e logo finaliza o processo porque não rodamos nenhum executável que o faria ficar ativo

```docker
docker run img_teste
```

Lista todos os containers ativos

```docker
docker ps
```

Lista todos os containers ativos e não ativos

```docker
docker ps -a
```

-i (modo interativo para manter o processo rodando)
-t (tty - para conseguir escrever coisas no terminal)

```docker
docker run -it ubuntu bash
```

--rm (todo processo de container que subir, na hora que ele sair, o docker já remove ele)

```docker
docker run -it --rm ubuntu bash
```

Levantar um container

```docker
//Levantar com o id
docker start container_id

// Levantar com o nome
docker start container_name
```

Cria um container do tipo webserver nginx que só poderá ser acessado no contexto do docker, ou seja, pelos containers que estão rodando junto com o container do nginx

```docker
docker run nginx
```

-p (publish - publica a porta que você quer apontar em relação a porta do container)
8080:80 (aponta a porta 8080 da máquina para a porta 80 do container nginx)

```docker
docker run -p 8080:80 nginx
```

-d (detached - libera o terminal depois que subir o container)

```docker
docker run -d -p 8080:80 nginx
```

Parar um container

```docker
// Parar com o id
docker stop container_id

// Parar com o nome
docker stop container_name
```

Remover um container

```docker
// Remover com o id
docker rm container_id

// Remover com o nome
docker rm container_name

// Remover com o -f (force) para casos como o container rodando
docker rm container_id -f
```

Nomear um container

```docker
docker run -d --name nginx -p 8080:80 nginx
```

Executar comandos em um container

```docker
// exec executa comandos em um container como o ls
docker exec container_name ls

// executar o bash e manter conexão com modo interativo e tty
docker exec -it container_name bash
```
