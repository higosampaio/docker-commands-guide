# Networks

As networks possibilitam a comunicação entre containers.

1. Network do tipo **_bridge_**: É o tipo de network padrão e mais comum. Normalmente utilizadas para fazer um container se comunicar com outro.

2. Network do tipo **_host_**: Permite mesclar a network do docker com a network do host do docker (minha máquina). A minha máquina terá a capacidade de acessar uma porta direta no container sem precisar fazer exposição de porta.

3. Network do tipo **_overlay_**: Permite a comunicação de containers entre máquinas diferentes. Geralmente utilizado em ambientes de maior escalabilidade.

4. Network do tipo macvlan: Permite setar um macaddress em um container e pode fazer parecer que é uma network que está plugada na sua rede.

5. Network do tipo none: Define que não terá nenhuma rede e garante que o container irá rodar de forma isolada.

## Trabalhando com bridge

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
