#!/bin/bash

# Verificamos los argumentos que llegan
if [ "$#" -ne 8 ]; then
    echo "Uso: $0 <nombre_vm> <tipo_so> <cpus> <memoria_ram_gb> <vram_mb> <tamano_disco_gb> <nombre_controlador_sata> <nombre_controlador_ide>"
    exit 1
fi

# Asignamos los argumentos a las variables
VM_NAME=$1
OS_TYPE=$2
CPUS=$3
RAM_GB=$4
VRAM_MB=$5
DISK_SIZE_GB=$6
SATA_CONTROLLER=$7
IDE_CONTROLLER=$8

# Convertimos la memoria y el disco a megabytes y megabits respectivamente
RAM_MB=$(($RAM_GB * 1024))
DISK_SIZE_MB=$(($DISK_SIZE_GB * 1024))

# Ruta en donde estran las maquinas
DISK_PATH="$HOME/VirtualBox VMs/$VM_NAME/$VM_NAME.vdi"

# Creamos la maquina virtual
VBoxManage createvm --name "$VM_NAME" --ostype "$OS_TYPE" --register

# Configurar el numero de CPUs, memoria RAM y VRAM
VBoxManage modifyvm "$VM_NAME" --cpus "$CPUS" --memory "$RAM_MB" --vram "$VRAM_MB"

# Crear y configurar el disco duro virtual
VBoxManage createhd --filename "$DISK_PATH" --size "$DISK_SIZE_MB"

# Crear y asociar el controlador SATA
VBoxManage storagectl "$VM_NAME" --name "$SATA_CONTROLLER" --add sata --controller IntelAHCI
VBoxManage storageattach "$VM_NAME" --storagectl "$SATA_CONTROLLER" --port 0 --device 0 --type hdd --medium "$DISK_PATH"

# Crear y asociar el controlador IDE para CD/DVD
VBoxManage storagectl "$VM_NAME" --name "$IDE_CONTROLLER" --add ide
VBoxManage storageattach "$VM_NAME" --storagectl "$IDE_CONTROLLER" --port 1 --device 0 --type dvddrive --medium emptydrive

# Imprimimos la configuracion creada
echo "============================"
echo "Configuración de la Máquina Virtual:"
echo "Nombre de la VM: $VM_NAME"
echo "Sistema Operativo: $OS_TYPE"
echo "CPUs: $CPUS"
echo "RAM: ${RAM_MB}MB"
echo "VRAM: ${VRAM_MB}MB"
echo "Tamaño del Disco Virtual: ${DISK_SIZE_GB}GB"
echo "Controlador SATA: $SATA_CONTROLLER"
echo "Controlador IDE: $IDE_CONTROLLER"
echo "============================"

