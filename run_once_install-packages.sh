#!/bin/bash -eux

# get the directory of this file
readonly REPOROOT="$( cd -- "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# install brew requirements
sudo apt update
# apt install -y build-essential procps curl file git

# # check if brew is installed or not
# # if brew is not installed, install brew
# if ! $(command -v brew &> /dev/null); then
#     echo "brew could not be found"
#     echo "installing brew..."
#     export NONINTERACTIVE=1
#     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#     # setup brew
#     (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /root/.profile
# fi

# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# # because brew recommends to install gcc
# brew install gcc

# # if it is not a devcontainer, install dev envs
# if [[ "${REMOTE_CONTAINERS-}" != "true" ]]; then
#     echo "installing dev envs..."
#     # brew install go pyenv poetry
# fi

# echo "installing zsh and starship..."
# brew install zsh
# brew install starship

# install shell requirements
if ! $(command -v zsh &> /dev/null); then
    sudo apt install -y zsh
fi
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
sudo apt install -y peco
curl -fsSL https://starship.rs/install.sh | sh -s -- --yes

# install dotfiles
cp "$REPOROOT/zshrc" ~/.zshrc
mkdir -p ~/.config
cp "$REPOROOT/starship.toml" ~/.config/starship.toml

# TODO: install git config (probably need to disable auto git config copy)
#       only when its not a devcontainer
