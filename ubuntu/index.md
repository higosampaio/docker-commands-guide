# Executando o Ubuntu

```docker
docker run -it --rm ubuntu bash
```

Ao executar esse comando, o docker realiza um pulling da imagem ubuntu, roda a imagem em um container e executa o bash do linux. O **_-it_** ou **_-i -t_** são flags que vão permitir a sua interação no container, e o **_--rm_** permite remover automaticamente o container depois que sair dele.

- **_-i_** (modo interativo para manter o processo rodando)
- **_-t_** (tty para conseguir escrever coisas no terminal)
- **_--rm_** (para remover o container)
