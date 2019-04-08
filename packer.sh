#!/bin/bash -x

which wget || echo "please install wget"
which unzip || echo "please install unzip"

if [ ! -f ./packer ]
then
    if [ "$(uname)" == "Darwin" ]
    then
        wget https://releases.hashicorp.com/packer/1.3.1/packer_1.3.1_darwin_amd64.zip
        unzip packer_1.3.1_darwin_amd64.zip
        rm packer_1.3.1_darwin_amd64.zip
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]
    then
        wget https://releases.hashicorp.com/packer/1.3.1/packer_1.3.1_linux_amd64.zip
        unzip packer_1.3.1_linux_amd64.zip
        rm packer_1.3.1_linux_amd64.zip
    fi
    chmod +x ./packer
fi

if [ ! -f ./packer-builder-osc-ebssurrogate ]
then
    if [ "$(uname)" == "Darwin" ]
    then
        wget https://github.com/remijouannet/packer-osc-plugins/releases/download/v0.3/packer-osc-darwin_amd64_v0.3.zip
        unzip packer-osc-darwin_amd64_v0.3.zip
        rm packer-osc-darwin_amd64_v0.3.zip
        mv ./packer-osc-darwin_amd64_v0.3/packer-builder-osc-ebssurrogate ./packer-builder-osc-ebssurrogate
        rm -f ./packer-osc-darwin_amd64_v0.3/packer-*
        rmdir ./packer-osc-darwin_amd64_v0.3/
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        wget https://github.com/remijouannet/packer-osc-plugins/releases/download/v0.3/packer-osc-linux_amd64_v0.3.zip
        unzip packer-osc-linux_amd64_v0.3.zip
        rm packer-osc-linux_amd64_v0.3.zip
        mv ./packer-osc-linux_amd64_v0.3/packer-builder-osc-ebssurrogate ./packer-builder-osc-ebssurrogate
        rm -f ./packer-osc-linux_amd64_v0.3/packer-*
        rmdir ./packer-osc-linux_amd64_v0.3/
    fi
    chmod +x ./packer-builder-osc-ebssurrogate
fi

./packer $@
