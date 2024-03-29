
## Wireguard & Pihole VPN

Wireguard and Pihole Docker Setup for VPN with Ad Blocker.

<p align=center>
  <img src="https://github.com/W0-ow/wireguard-pihole/assets/121321031/8da1faa7-1026-493f-a489-b64c59699ec6" width=50% height=50%>
</p>

## Requirements

- [VPS with Ubuntu 22.0.4](https://aws.amazon.com/es/what-is/vps/)
- [Wireguard client](https://www.wireguard.com/install/)
- [Docker](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-22-04)
- [Docker Compose](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-22-04)
- [Crontab](https://crontab.guru/)


## Configuration

Connect with your server via SSH

```bash
ssh -i <private_key> <server_dns_or_ip>
```

Update your server

```bash
sudo apt update
```

---

**‼️ Install [Docker](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-22-04), [Docker Compose](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-22-04) and [Crontab](https://crontab.guru/)**

---

Clone this repository

```bash
git clone https://github.com/W0-ow/wireguard-pihole.git ~/wireguard
```

Go to the project directory

```bash
cd ~/wireguard
```

Edit env files

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

See active containers

```bash
Docker ps -a
```

```bash
CONTAINER ID   IMAGE                   COMMAND      CREATED          STATUS                             PORTS                                             NAMES
e907ac686b9a   linuxserver/wireguard   "/init"      12 seconds ago   Up 11 seconds                      0.0.0.0:51820->51820/udp, :::51820->51820/udp     guarguar
7fa024f848fe   pihole/pihole:latest    "/s6-init"   12 seconds ago   Up 11 seconds (health: starting)   53/tcp, 53/udp, 67/tcp, 80/tcp, 443/tcp, 67/udp   pihole
```

Add the **update.sh** script in Crontab to update Wireguard and Pihole monthly

```bash
sudo crontab -e
```

```bash
0 0 1 * * bash $HOME/wireguard/update.sh
```

Exit the server

```bash
exit
```

---

**‼️ Don't forget to add the Wireguard (51820) and Pihole (27017) port in your server's firewall inbound rules**
- [Aws](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-security-groups.html)
- [Azure](https://learn.microsoft.com/en-us/answers/questions/1190066/how-can-i-open-a-port-in-azure-so-that-a-constant)

---

Copy the directory containing the configuration files for the Wireguard client

```bash
scp -i <private_key> -r <server_dns_or_ip>:~/wireguard/config ./
```

Import tunnel (peer.conf) from config directory to your Wireguard client

<p align=center>
  <img src="https://github.com/W0-ow/wireguard-pihole/assets/121321031/fd59be35-3e90-41e5-b193-6b776f140304" width=80% height=80%>
</p>

---

**Activate the peer and go to [ipconfig.io](https://ipconfig.io/) to see if VPN is working**

<p align=center>
  <img src="https://github.com/W0-ow/wireguard-pihole/assets/121321031/d3d83315-0931-4cf1-8b75-b18f01e725dc" width=80% height=80%>
</p>

---

**To view the dashboard and Ad blocker info (Pihole) go [http://172.20.0.7/admin/](http://172.20.0.7/admin/)**

<p align=center>
  <img src="https://github.com/W0-ow/wireguard-pihole/assets/121321031/b6e95d30-8223-4abc-bc2e-312264295a75" width=80% height=80%>
</p>
