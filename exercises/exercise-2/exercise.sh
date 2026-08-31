sudo docker pull nginx:1.31.4

sudo docker images

sudo trivy image nginx:1.31.4

mkdir app

sudo docker build -t app:v1 .

sudo docker images

sudo trivy app:v1