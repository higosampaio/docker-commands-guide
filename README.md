# Docker Labs

<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#comandos-básicos">Comandos básicos</a></li>
    <li><a href="./hello-world/index.md">Rodando um Hello World</a></li>
    <li><a href="./ubuntu/index.md">Executando o Ubuntu</a></li>
    <li><a href="./publishing-doors/index.md">Publicando portas com nginx</a></li>
    <li><a href="./commands-outside/index.md">Executar comandos diretamente em um container</a></li>
    <li><a href="./bind-mounts/index.md">Bind Mounts</a></li>
    <li><a href="./volumes/index.md">Trabalhando com volumes</a></li>
    <li><a href="./imagens/index.md">Trabalhando com imagens</a></li>
    <li><a href="./entrypoint-vs-cmd/index.md">ENTRYPOINT vs CMD</a></li>
    <li><a href="./publishing-dockerhub/index.md">Publicando imagem no DockerHub</a></li>
    <li><a href="./networks/index.md">Networks</a></li>
    <li><a href="./multistage-building/index.md">Otimizando imagens</a></li>
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
