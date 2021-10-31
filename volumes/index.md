# Trabalhando com volumes

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
