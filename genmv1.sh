#!/bin/bash

set +x

#VM_NAME="Debian1"
VM_NAME="$2"

RAM=4096
OS_TYPE="Debian_64"
DISK_SIZE=65536

	
	
	
VM_PATH="$HOME/VirtualBox VMs/$VM_NAME"
DISK_PATH="$VM_PATH/${VM_NAME}_disk.vdi"

if [ "$1" = "L" ]; then
	VBoxManage list vms 2> /dev/null | while IFS= read -r line; do
		VM_NAME=$(echo "$line" | awk -F'"' '{print $2}')
		[ -z "$VM_NAME" ] && continue
        CREATED_DATE=$(VBoxManage getextradata "$VM_NAME" "CreatedDate" 2>/dev/null | sed -n 's/^Value: //p')
        if [ -z "$CREATED_DATE" ]; then
        	CREATED_DATE=$(date '+%Y-%m-%d %H:%M:%S')
        	VBoxManage setextradata "$VM_NAME" "CreatedDate" "$CREATED_DATE"
    	fi

        CREATED_BY=$(VBoxManage getextradata "$VM_NAME" "CreatedBy" 2>/dev/null | sed -n 's/^Value: //p')
        if [ -z "$CREATED_BY" ]; then
        	CREATED_BY="$USER"
        	VBoxManage setextradata "$VM_NAME" "CreatedBy" "$CREATED_BY"
    	fi


        echo " VM: $VM_NAME"
        echo " Créée le: $CREATED_DATE"
        echo " Créée par: $CREATED_BY"
        echo ""
    
    done 
    
		
elif [ "$1" = "N" ]; then
	VBoxManage createvm --name "$VM_NAME" 2> /dev/null 
	V="$?"
	if [ "$V" != 0 ]; then
    		echo "Le nom de la VM est déjà utilisé"
    		exit
	else
    		echo "La VM était crée"
	fi
	VBoxManage registervm "$VM_PATH/$VM_NAME.vbox" 2> /dev/null
	if [ "$?" != 0 ]; then
		echo "Impossible d'enregistrer la VM '$VM_NAME' "
	else 
		echo "La VM '$VM_NAME'a été enregistrer avec succès"
	fi
	VBoxManage modifyvm "$VM_NAME" --memory "$RAM" --nic1 nat --boot1 net 2> /dev/null
	if [ "$?" != 0 ]; then
		echo "Impossible de modifier la configuration de la VM '$VM_NAME'"
	else 
		echo " La VM '$VM_NAME'a été configurée avec succès"
	fi
	VBoxManage createmedium disk --filename "$DISK_PATH" --size "$DISK_SIZE" --format VDI 2> /dev/null
	VBoxManage storagectl "$VM_NAME" --name "SATA Controller" --add sata --controller IntelAhci 2> /dev/null
	VBoxManage storageattach "$VM_NAME" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$DISK_PATH" 2> /dev/null
elif [ "$1" = "S" ]; then 
#read
	VBoxManage unregistervm "$VM_NAME" --delete 2> /dev/null
	if [ "$?" != 0 ]; then
		echo "Impossible de supprimer la VM '$VM_NAME'"
	else 
		echo " La VM '$VM_NAME'a été supprimée avec succès"
	fi
elif [ "$1" = "D" ]; then
	VBoxManage startvm "$VM_NAME" 2> /dev/null
elif [ "$1" = "A" ]; then
	VBoxManage controlvm "$VM_NAME" poweroff 2> /dev/null
fi

