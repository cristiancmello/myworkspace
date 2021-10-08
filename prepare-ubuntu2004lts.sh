#!/usr/bin/env bash

sudo apt update ; sudo apt upgrade -y

# Installing Development Tools
sudo apt install build-essential -y
sudo bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)" # LLVM and Clang tools

# LLVM 13
wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add -
sudo apt install -y \
    libllvm-13-ocaml-dev libllvm13 llvm-13 llvm-13-dev llvm-13-doc \
    llvm-13-examples llvm-13-runtime clang-13 clang-tools-13 clang-13-doc \
    libclang-common-13-dev libclang-13-dev libclang1-13 clang-format-13 \
    python3-clang-13 clangd-13 libfuzzer-13-dev lldb-13 lld-13 libc++-13-dev libc++abi-13-dev \
    libomp-13-dev libclc-13-dev libunwind-13-dev

sudo apt install -y exuberant-ctags unzip direnv

echo "eval \"\$(direnv hook bash)\"" >> ~/.bashrc

git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/Vundle.vim

cp .vimrc ~/.vimrc
vim '+PluginInstall' +qall

# Installing OhMyPosh
sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh
mkdir ~/.poshthemes
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
chmod u+rw ~/.poshthemes/*.json
rm ~/.poshthemes/themes.zip

# Set Posh theme
echo -e "POSHTHEME=\"mt.omp.json\"\neval \"\$(oh-my-posh --init --shell bash --config ~/.poshthemes/\${POSHTHEME})\"\n" >> ~/.bashrc

# Installing Specific Development Tools
###
# GOLANG
###
curl -OL https://golang.org/dl/go1.16.7.linux-amd64.tar.gz && sha256sum go1.16.7.linux-amd64.tar.gz
sudo tar -C /usr/local -xvf go1.16.7.linux-amd64.tar.gz

echo -e "
export PATH=\$PATH:/usr/local/go/bin
export GOPATH=\$(go env GOPATH)
" >> ~/.profile

# Clean Up
sudo apt clean ; sudo apt autoclean ; sudo apt autoremove
