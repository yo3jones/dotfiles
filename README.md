# dotfiles

## Get yconfig

### PI

```
curl \
  -L \
  https://github.com/yo3jones/yconfig/releases/latest/download/yconfig-linux-arm64 \
  --output yconfig \
&& chmod +x yconfig
```

### M1 Mac

```
curl \
  -L \
  https://github.com/yo3jones/yconfig/releases/latest/download/yconfig-darwin-arm64 \
  --output yconfig \
&& chmod +x yconfig
```

### Mac

```
curl \
  -L \
  https://github.com/yo3jones/yconfig/releases/latest/download/yconfig-darwin-amd64 \
  --output yconfig \
&& chmod +x yconfig
&& sudo mv yconfig /usr/local/bin
```

### Linux

```
curl \
  -L \
  https://github.com/yo3jones/yconfig/releases/latest/download/yconfig-linux-amd64 \
  --output yconfig \
&& chmod +x yconfig
```

## Pi

```
sudo apt update \
&& sudo apt upgrade -y \
&& sudo reboot
```

## git
```
ssh-keygen -t ed25519 -f "$HOME/.ssh/gh" -C "your_email@example.com"
```

~/.ssh/config:
```
Host github.com
        User git
        Hostname github.com
        PreferredAuthentications publickey
        IdentityFile /home/pi/.ssh/gh
```


