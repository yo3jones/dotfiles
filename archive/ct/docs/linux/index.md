# Linux Setup

> Examples are for Ubuntu

## Create Access

### Create SSH Key

> Do this locally

```
ssh-keygen -f ~/.ssh/digital-ocean-code
cat ~/.ssh/digital-ocean-code.pub | pbcopy
```

### Create User

```
ssh -i ~/.ssh/digital-ocean-code root@${ip}
adduser chris
mkdir /home/chris/.ssh/
echo '${public key}' > /home/chris/.ssh/authorized_keys
chown -R chris:chris /home/chris/.ssh/
chmod 700 /home/chris/.ssh/
```

### Connect to GitHub

```

```
