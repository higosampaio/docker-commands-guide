# Trabalhando com Bind Mounts

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
