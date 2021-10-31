# Executar comandos diretamente em um container

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
