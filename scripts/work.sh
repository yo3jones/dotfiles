#/bin/bash

set -e

# git clone https://github.com/yo3jones/dotfiles.git
# cd dotfiles
# ./scripts/work.sh

curl -L \
  $(fwdproxy-config curl) \
  https://github.com/yo3jones/yconfig/releases/latest/download/yconfig-linux-amd64 \
  --output yconfig
chmod +x yconfig

yconfig generate --tag work

yconfig setup --tag work
