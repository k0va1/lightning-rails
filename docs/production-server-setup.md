## How to prepare VPS for deploy?

### Hetzner

1. Login to your server with `root` user

2. Intall [Docker](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)

```
apt-get update
apt-get install ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

3. Create `www` user

`useradd -m -s /bin/bash --groups docker www`

4. Add SSH access to the user

```
su www
cd
mkdir .ssh
chmod 700 .ssh
cd .ssh
touch authorized_keys
chmod 600 authorized_keys

# On you local machine
cat ~/.ssh/id_rsa.pub | pbcopy

# Back to server
cat >> authorized_keys
# Ctrl-D

exit
```
