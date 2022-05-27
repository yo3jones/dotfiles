## git

```
git clone git@github.com:yo3jones/dotfiles.git
```

```
ssh-keygen -t ed25519 -C "your_email@example.com"
```

~/.ssh/config:
```
Host github.com
        User git
        Hostname github.com
        PreferredAuthentications publickey
        IdentityFile /home/pi/.ssh/gh
```
