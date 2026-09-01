sudo docker build -t harbor.container.it-scholar.com/seminar/ben-coeppicus:v4 .

sudo docker compose up -d

curl http://localhost:9191

sudo docker build -t harbor.container.it-scholar.com/seminar/ben-coeppicus:v5 --build-arg PORT=8484 .

sudo docker compose up -d

curl http://localhost:9191