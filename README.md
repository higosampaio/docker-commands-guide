# Docker Commands Guide

<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#comandos-básicos">Comandos básicos</a></li>
    <li><a href="#hello-world">Hello World</a></li>
    <li><a href="#executando-o-ubuntu">Executando o Ubuntu</a></li>
    <li><a href="#publicando-portas-com-o-nginx">Publicando portas com nginx</a></li>
    <li><a href="#executar-diretamente-comandos-em-um-container">Executar diretamente comandos em um container</a></li>
    <li><a href="#bind-mounts">Bind Mounts</a></li>
    <li><a href="#trabalhando-com-volumes">Trabalhando com volumes</a></li>
    <li><a href="#trabalhando-com-imagens">Trabalhando com imagens</a></li>
    <li><a href="#criando-imagem-com-o-dockerfile">Criando imagem com o Dockerfile</a></li>
    <li><a href="#entrypoint-vs-cmd">ENTRYPOINT vs CMD</a></li>
  </ol>
</details>

## Comandos básicos

```docker
# Listar containers ativos
docker ps

# Listar todos os containers ativos e não ativos
docker ps -a

# Levantar um container
docker start container_id

# Parar um container
docker stop container_id

# Remover um container
docker rm container_id

# Remover com o -f (force) para o caso do container rodando
docker rm container_id -f

# Remover todos os containers de uma vez
docker rm $(docker ps -a -q) -f
```

## Hello World

Ao rodar o seguinte comando, o docker procura na sua máquina uma imagem com o nome hello-world para rodar em um container. Caso a imagem não exista, o docker tenta procurar essa imagem no container registry e depois roda num container através do **_run_**.

```docker
docker run hello-world
```

Esse hello-world é uma imagem que existe no container registry, portanto, o docker consegue fazer um pulling da imagem para a sua máquina e depois rodar.

O comando **_docker run_** faz com que configurações de ENTRYPOINT ou CMD de uma imagem sejam executados. Em nosso caso, o ENTRYPOINT da hello-world apenas imprime uma mensagem e finaliza o processo.

## Executando o Ubuntu

Rodando o ubuntu em um container e executando o bash do linux. O **_-it_** ou **_-i -t_** são flags que vão permitir a sua interação no container, e o **_--rm_** permite remover automaticamente o container depois que sair dele.

```docker
docker run -it --rm ubuntu bash
```

- **_-i_** (modo interativo para manter o processo rodando)
- **_-t_** (tty para conseguir escrever coisas no terminal)
- **_--rm_** (para remover o container)

## Publicando portas com nginx

Criando um container do tipo webserver nginx que só poderá ser acessado no contexto do docker, ou seja, pelos containers que estão rodando junto com o container do nginx.

```docker
docker run -d --name nginx -p 8080:80 nginx
```

- **_-d_** (detached - libera o terminal depois que subir o container)
- **_--name_** (para nomear o container)
- **_-p_** (aponta a porta 8080 da máquina para a porta 80 do container nginx)

## Executar diretamente comandos em um container

O comando exec permite rodar comandos da máquina que afetam diretamente arquivos que estão no escopo do container.

```docker
# Executar uma listagem de arquivos que está dentro do container
docker exec container_name ls

# Executar o bash e manter conexão com modo interativo
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

```docker
# Criando um volume
docker volume create volume_name

# Verificando as configurações de um volume
docker volume inspect volume_name

# Mapeando um volume para dentro de uma pasta /app no container
docker run --name nginx -d --mount type=volume,source=volume_name,target=/app nginx

# Matar tudo o que não está sendo usado dos volumes na sua máquina. Isso evita lotação de espaço na sua máquina.
docker volume prune
```

## Trabalhando com imagens

Podemos criar containers a partir de imagens que ficam hospedadas em algum container registry. Por padrão o docker usar o container registry Docker Hub, mas isso não o impede de usar outros containers registry ou até o seu próprio.

```docker
# Baixando uma imagem para a sua máquina
docker pull image_name

# Listando as imagens existentes
docker images

# Removendo uma imagem
docker rmi image_name
```

## Criando imagem com o Dockerfile

Gerando uma imagem. O **_-t_** nomeia o _repository_ e o **_._** indica em qual pasta do seu computador existe o Dockerfile.

```docker
docker build -t higosampa/nginx-com-vim .
```

## ENTRYPOINT vs CMD

O ENTRYPOINT e o CMD são comandos que executam ações ao rodar a imagem. A diferença é que o CMD é um comando variável, podendo ser alterado em tempo de execução e o ENTRYPOINT é um comando fixo. O CMD pode ser usado como parâmetro do ENTRYPOINT.

Criando uma imagem baseada no ubuntu e printamos uma mensagem "Hello World".

```docker
FROM ubuntu:latest

ENTRYPOINT [ "echo", "Hello" ]

CMD [ "World" ]
```

Podemos altearar o CMD da seguinte forma:

```docker
docker run --rm higosampa/hello X
# Output: Hello X
```
