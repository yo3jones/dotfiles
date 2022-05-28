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
