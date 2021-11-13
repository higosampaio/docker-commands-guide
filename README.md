# Docker Labs

<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#hello-world">Rodando um Hello World</a></li>
    <li><a href="#executando-o-ubuntu">Executando o Ubuntu</a></li>
    <li><a href="#publicando-portas-com-nginx">Publicando portas com nginx</a></li>
    <li><a href="#executar-comandos-diretamente-em-um-container">Executar comandos diretamente em um container</a></li>
    <li><a href="./bind-mounts/index.md">Bind Mounts</a></li>
    <li><a href="./volumes/index.md">Trabalhando com volumes</a></li>
    <li><a href="./imagens/index.md">Trabalhando com imagens</a></li>
    <li><a href="./entrypoint-vs-cmd/index.md">ENTRYPOINT vs CMD</a></li>
    <li><a href="./publishing-dockerhub/index.md">Publicando imagem no DockerHub</a></li>
    <li><a href="./networks/index.md">Networks</a></li>
    <li><a href="./install-framework/index.md">Instalando framework em um container</a></li>
    <li><a href="./create-app/index.md">Desenvolvendo uma aplicação com infraestrutura no Docker</a></li>
    <li><a href="./multistage-building/index.md">Otimizando imagens</a></li>
    <li><a href="./docker-compose">Iniciando com docker-compose</a></li>
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

## Trabalhando com Bind Mounts

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
