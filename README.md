
## Docker - Wireguard & Pihole

WirtGuard and Pihole Docker Setup for VPN.


## Requirements

- [VPS with Ubuntu 22.0.4](https://aws.amazon.com/es/what-is/vps/)

- [Docker](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-22-04)

- [Docker Compose](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-22-04)

- [Crontab](https://crontab.guru/)


## Configuration

Connect with your server via SSH

```bash
ssh -i <private_key> <server_domain_or_ip>
```

Update your server

```bash
sudo apt update
```

Clone this repo

```bash
git clone https://github.com/W0-ow/wireguard-pihole.git ./wireguard
```

Go to the project directory

```bash
cd /wireguard
```

Configure env files

```bash
vim wireguard.env
```
```env
  PUID=1000
  PGID=1000
  TZ=Europe/London           # your server's time zone
  SERVERURL=0.0.0.0          # optional -> server ip
  SERVERPORT=51820           # optional -> default port
  PEERS=2                    # optional -> number of devices you want to connect
  PEERDNS=auto               # optional
  INTERNAL_SUBNET=10.13.13.0 # optional
```
```bash
vim pihole.env
```
```env
  TZ=Europe/London     # your server's time zone
  WEBPASSWORD=password # pihole password
```

Build images and start containers

```bash
Docker compose up -d
```

