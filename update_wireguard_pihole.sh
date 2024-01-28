#! /bin/bash

# cd capeta wireguard que es en donde tenemos el archivo yml
cd ~/wireguard

# tiramos todos los contenedores en funcionamiento
docker compose down

# borramos las imagenes de wireguard y pihole,
docker rmi linuxserver/wireguard
docker rmi pihole/pihole:latest

# construimos de nuevo las imagenes
docker build ./docker-compose.yml

# levantamos los contenedores
docker compose up -d
