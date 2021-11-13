# Docker Labs

<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#hello-world">Rodando um Hello World</a></li>
    <li><a href="#executando-o-ubuntu">Executando o Ubuntu</a></li>
    <li><a href="#publicando-portas-com-nginx">Publicando portas com nginx</a></li>
    <li><a href="#executar-comandos-diretamente-em-um-container">Executar comandos diretamente em um container</a></li>
    <li><a href="#bind-mounts">Bind Mounts</a></li>
    <li><a href="#trabalhando-com-volumes">Trabalhando com volumes</a></li>
    <li><a href="#trabalhando-com-imagens">Trabalhando com imagens</a></li>
    <li><a href="#entrypoint-vs-cmd">ENTRYPOINT vs CMD</a></li>
    <li><a href="#publicando-imagem-no-dockerhub">Publicando imagem no DockerHub</a></li>
    <li><a href="#networks">Networks</a></li>
    <li><a href="#multistage-building">Multistage Building</a></li>
    <li><a href="#reverse-proxy">Reverse Proxy</a></li>
  </ol>
</details>

## Hello World

```docker
docker run hello-world
```

Ao executar esse comando, o docker procura em sua máquina local uma imagem com o nome hello-world para rodar em um container. Caso a imagem não exista, o docker tenta procurar essa imagem no container registry. Esse hello-world é uma imagem que existe no container registry Docker Hub, portanto, o docker consegue fazer um pulling da imagem para a sua máquina e depois rodar.

O comando **_docker run_** faz com que configurações de ENTRYPOINT ou CMD de uma imagem sejam executados. Em nosso caso, o ENTRYPOINT da hello-world apenas imprime uma mensagem e finaliza o processo.

## Executando o Ubuntu

```docker
docker run -it --rm ubuntu bash
```

Ao executar esse comando, o docker realiza um pulling da imagem ubuntu, roda a imagem em um container e executa o bash do linux. O **_-it_** ou **_-i -t_** são flags que vão permitir a sua interação no container, e o **_--rm_** permite remover automaticamente o container depois que sair dele.

- **_-i_** (modo interativo para manter o processo rodando)
- **_-t_** (tty para conseguir escrever coisas no terminal)
- **_--rm_** (para remover o container)

## Publicando portas com nginx

```docker
docker run -d --name nginx -p 8080:80 nginx
```

Esse comando cria um container nginx que só poderá ser acessado no contexto do docker, ou seja, pelos containers que estão rodando junto com o container do nginx.

- **_-d_** (detached - libera o terminal depois que subir o container)
- **_--name_** (para nomear o container)
- **_-p_** (aponta a porta 8080 da máquina para a porta 80 do container nginx)

## Executar comandos diretamente em um container

O exec e o attach permitem rodar comandos da máquina local que afetam diretamente arquivos que estão no escopo do container.

Executar uma listagem de arquivos que está dentro do container

```docker
docker exec container_name ls
```

Executar o bash e manter conexão com modo interativo

```docker
docker exec -it container_name bash
```

Executar o bash e manter conexão com modo interativo com o attach

```docker
docker attach nome_container
```

## Bind Mounts

Bind Mounts serve para refletir arquivos da sua máquina local para o container. Dessa forma você mantem a integridade do arquivo caso o container não exista mais.

O **_-v_** pode ser usado para isso, refletindo o index.html de "$(pwd)"/bind-mounts/html/ para o diretório /usr/share/nginx/html do nginx no container.

```docker
docker run -d --name nginx -p 8080:80 -v "$(pwd)"/bind-mounts/html/:/usr/share/nginx/html nginx
```

Existe também uma forma mais moderna para o mesmo comando usando as flags **_--mount_**, **_type_** e **_source_**.

```docker
docker run -d --name nginx -p 8080:80 --mount type=bind,source="$(pwd)"/bind-mounts/html/,target=/usr/share/nginx/html nginx
```

Existem diferenças entre usar o **_-v_** ou **_--mount_**. A principal delas é que o **_-v_** cria um arquivo ou diretório caso não exista na sua máquina. A exemplo disso, um comando que cria um dir x que não existia no dir html.

```docker
docker run -d -v "$(pwd)"/bind-mounts/html/x:/usr/share/nginx/html nginx
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

Excluir tudo o que não está sendo usado dos volumes na sua máquina. Isso evita lotação de espaço.

```docker
docker volume prune
```

## Trabalhando com imagens

Podemos criar containers a partir de imagens que ficam hospedadas em algum container registry. Por padrão o docker usar o container registry Docker Hub, mas isso não o impede de usar outros containers registry ou até o seu próprio.

Baixando uma imagem para a sua máquina

```docker
docker pull image_name
```

Listando as imagens existentes

```docker
docker images
```

Removendo uma imagem

```docker
docker rmi image_name
```

Gerando uma imagem a partir de um Dockerfile.

```docker
docker build -t higosampa/nginx-com-vim .
```

O **_-t_** nomeia o _repository_ e o **_._** indica em qual pasta do seu computador existe o Dockerfile.

## ENTRYPOINT vs CMD

O ENTRYPOINT e o CMD são comandos que executam ações ao rodar a imagem. A diferença é que o CMD é um comando variável, podendo ser alterado em tempo de execução e o ENTRYPOINT é um comando fixo. O CMD pode ser usado como parâmetro do ENTRYPOINT.

Criando uma imagem baseada no ubuntu e printando uma mensagem "Hello World".

```docker
FROM ubuntu:latest

ENTRYPOINT [ "echo", "Hello" ]

CMD [ "World" ]

# output: Hello World
```

Podemos alterar o CMD da seguinte forma:

```docker
docker run --rm higosampa/hello X

# output: Hello X
```

## Publicando imagem no DockerHub

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

## Networks

As networks possibilitam a comunicação entre containers.

1. Network do tipo **_bridge_**: É o tipo de network padrão e mais comum. Normalmente utilizadas para fazer um container se comunicar com outro.

2. Network do tipo **_host_**: Permite mesclar a network do docker com a network do host do docker (minha máquina). A minha máquina terá a capacidade de acessar uma porta direta no container sem precisar fazer exposição de porta.

3. Network do tipo **_overlay_**: Permite a comunicação de containers entre máquinas diferentes. Geralmente utilizado em ambientes de maior escalabilidade.

4. Network do tipo macvlan: Permite setar um macaddress em um container e pode fazer parecer que é uma network que está plugada na sua rede.

5. Network do tipo none: Define que não terá nenhuma rede e garante que o container irá rodar de forma isolada.

### Trabalhando com bridge

Verificando os comandos disponíveis para trabalhar com networks

```docker
docker networks
```

Identificando os containers que fazem parte de uma network

```docker
docker network inspect bridge
```

Criando uma nova network

```docker
docker network create --driver bridge minharede
```

Criando containers na mesma rede

```docker
docker run -dit --name ubuntu1 --network minharede bash
docker run -dit --name ubuntu2 --network minharede bash
```

Conectando um container já existente em uma rede

```docker
docker network connect minharede container_name
```

## Multistage Building

A otimização de imagens é comumente utilizada para colocar imagens em ambiente de produção. Quanto mais enxuta a imagem ficar, mais leve e menos vulnerável a falhas ela fica. Geralmente utiliza-se imagens baseadas no Alpine Linux para reduzir o tamanho de uma imagem que você queira otimizar.

O Multistage Build é uma forma de se trabalhar o build de uma imagem em duas ou mais etapas, e dessa forma podemos fazer um build principal e um secundário baseado no Apine Linux para otimizar. Neste <a href="laravel/Dockerfile.prod">Dockerfile</a> há um exemplo.

## Reverse Proxy

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

Obs. Caso o projeto em laravel tenha imagens (.png, .jpg, etc), será preciso copiar os arquivos pra dentro do nginx porque o php-fpm não vai servir as imagens.
