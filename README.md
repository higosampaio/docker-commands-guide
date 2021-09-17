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

## Bind Mounts

O comando -v reflete um arquivo da sua máquina para um container. Dessa forma você mantem a integridade do arquivo caso o container não exista mais.

```docker
docker run -d --name nginx -p 8080:80 -v ~/www/docker/html/:/usr/share/nginx/html nginx
```

Existe também uma forma mais moderna para o mesmo comando usando as flags **_--mount, type e source_**.

```docker
docker run -d --name nginx -p 8080:80 --mount type=bind,source="$(pwd)"/html/,target=/usr/share/nginx/html nginx
```

Existem diferenças entre usar o **_-v_** ou **_--mount_**. A principal delas é que o **_-v_** cria um arquivo ou diretório caso não exista na sua máquina. A exemplo disso, um comando que cria um dir x que não existia no dir html.

```docker
docker run -d -v "$(pwd)"/html/x:/usr/share/nginx/html nginx
```

O **_--mount_** dispara um erro dizendo basicamente que não existe diretório x na sua máquina para ser montado no container.

## Trabalhando com volumes

Quando queremos persistir arquivos dos nossos containers em uma máquina, seja ela local ou não, quando queremos compartilhar esses arquivos entre containers, manter o mesmo tipo de filesystem (Linux Virtual Machine - que o Docker usa), e principalmente quando não sabemos ou não temos controle dos caminhos dos diretórios, usamos o conceito de volume.

Criando um volume

```docker
docker volume create volume_name
```

Verificando as configurações de um volume

```docker
docker volume inspect volume_name
```

Mapeando um volume para dentro de uma pasta /app no container

```docker
docker run --name nginx -d --mount type=volume,source=volume_name,target=/app nginx
```

Matar tudo o que não está sendo usado dos volumes na sua máquina. Isso evita lotação de espaço na sua máquina.

```docker
docker volume prune
```

## Trabalhado com imagens

Podemos criar containers a partir de imagens que ficam hospedadas em algum container registry. Por padrão o docker usar o container registry Docker Hub, mas isso não impede de usar outros containers registry ou até o seu próprio.

Baixando uma imagem para a sua máquina

```docker
docker pull image_name
```

Listando as imagens existentes

```docker
docker images
```

Removendo imagens. Os : são opcionais e podem indicar uma tag específica que representa a versão da imagem. Por padrão a tag é latest, e se não escrita no comando, ela fica implícita.

```docker
docker rmi image_name:latest
```

Gerando uma imagem. O **_-t_** define qual o nome do repositorio que você quer colocar e o **_._** indica em qual pasta do seu computador existe o Dockerfile.

```docker
docker build -t higosampa/nginx-com-vim .
```
