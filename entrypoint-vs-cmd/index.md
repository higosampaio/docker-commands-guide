# ENTRYPOINT vs CMD

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
