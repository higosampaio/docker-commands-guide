# Otimizando imagens utilizando Multistage Building

A otimização de imagens é comumente utilizada para colocar imagens em ambiente de produção. Quanto mais enxuta a imagem ficar, mais leve e menos vulnerável a falhas ela fica. Geralmente utiliza-se imagens baseadas no Alpine Linux para reduzir o tamanho de uma imagem que você queira otimizar.

O Multistage Build é uma forma de se trabalhar o build de uma imagem em duas ou mais etapas, e dessa forma podemos fazer um build principal e um secundário baseado no Apine Linux para otimizar. Neste <a href="laravel/Dockerfile.prod">Dockerfile</a> há um exemplo.
