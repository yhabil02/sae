#!/bin/bash

set +x

VM_NAME="Debian46"
RAM=4096
OS_TYPE="Debian_64"

VM_PATH="$HOME/VirtualBox VMs/$VM_NAME"

VBoxManage createvm --name "$VM_NAME">/dev/null

V="$?"

if [ "$V" != 0 ]; then
    echo "Le nom de la VM est déjà utilisé"
else
    echo "La VM était crée"
fi

VBoxManage registervm "$VM_PATH/$VM_NAME.vbox"


VBoxManage modifyvm "$VM_NAME" --memory "$RAM"

read
VBoxManage unregistervm "$VM_NAME" --delete

