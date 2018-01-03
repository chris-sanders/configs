#!/usr/bin/env bash

# Declare repositories and target folder
declare -A repos
repos=(
["https://github.com/chris-sanders/configs.git"]="$HOME/src/configs" 
["https://github.com/chris-sanders/maas-lxd.git"]="$HOME/src/maas-lxd" 
["https://github.com/VundleVim/Vundle.vim.git"]="$HOME/.vim/bundle/Vundle.vim" 
["https://github.com/sickill/vim-monokai.git"]="$HOME/src/vim-monokai"
["https://github.com/openstack-charmers/openstack-on-lxd.git"]="$HOME/src/openstack-on-lxd"
["https://github.com/chris-sanders/charm-interface-ceph-mds.git"]="$HOME/src/juju/charms/interfaces/ceph-mds"
["https://github.com/chris-sanders/charm-ceph-fs.git"]="$HOME/src/juju/charms/layers/charm-ceph-fs"
["https://github.com/chris-sanders/charm-ceph-mon.git"]="$HOME/src/juju/charms/nolayer/ceph-mon"
["https://github.com/chris-sanders/charm-ceph-osd.git"]="$HOME/src/juju/charms/nolayer/ceph-osd"
)

# Clone repos
for repo in "${!repos[@]}"; do
    if [ ! -d ${repos[$repo]} ]; then
	git clone $repo ${repos[$repo]}
    fi
done

# Packages
pkgs=(
cmake
build-essential
python-dev
python3-dev
tox
squashfuse
)

for pkg in "${pkgs[@]}"
do
    sudo apt-get install -y $pkg
done

# Setup Vim
cp $HOME/src/configs/vim/.vimrc $HOME/
cp -r $HOME/src/vim-monokai/colors $HOME/.vim/
vim -c :VundleInstall
(cd $HOME/.vim/bundle/YouCompleteMe; ./install.py)

# Setup bashrc
if [[ ! -v JUJU_REPOSITORY ]]; then
    cat $HOME/src/configs/bash/.bashrc >> $HOME/.bashrc
fi

