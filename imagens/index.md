# Trabalhando com imagens

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
