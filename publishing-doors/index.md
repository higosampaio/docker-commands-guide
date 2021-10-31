# Publicando portas com nginx

```docker
docker run -d --name nginx -p 8080:80 nginx
```

Esse comando cria um container nginx que só poderá ser acessado no contexto do docker, ou seja, pelos containers que estão rodando junto com o container do nginx.

- **_-d_** (detached - libera o terminal depois que subir o container)
- **_--name_** (para nomear o container)
- **_-p_** (aponta a porta 8080 da máquina para a porta 80 do container nginx)
