#!/usr/bin/env bash
if [[ 1 ]];then
  exit 1
fi

# BUILD AND IMAGE
sudo docker build -t example-scratch .
sudo docker run -it example-scratch

# COMPILE and RUN GO APPLICATION
CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .
go run app.go


# DOCKER COMPOSE
docker-compose up -d
docker-compose ps

Name            Command            State            Ports
------------------------------------------------------------------
ghost   /entrypoint.sh npm start   Up      0.0.0.0:80->2368/tcp
mysql   /entrypoint.sh mysqld      Up      0.0.0.0:32770->3306/tcp

docker exec -ti mysql bash
root@user:/# ping ghost
