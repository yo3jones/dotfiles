#!/bin/bash

# sudo apt-get install -y curl zsh ripgrep fzf tmux tmuxinator k9s
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
#     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
mkdir ~/.config
mkdir ~/.config/nvim
rm $HOME/.zshrc
ln -s $HOME/dotfiles/zshrc $HOME/.zshrc
# rm $HOME/.tmux.conf
ln -s $HOME/dotfiles/tmux.conf $HOME/.tmux.conf
ln -s $HOME/dotfiles/init.vim $HOME/.config/nvim/init.vim
ln -s $HOME/dotfiles/tmuxinator.nebula.yml $HOME/.config/tmuxinator/nebula.yml
nvm install 13
