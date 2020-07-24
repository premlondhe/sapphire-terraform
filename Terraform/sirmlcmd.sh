#!/bin/bash
RESOURCEGROUP=$1
VMName=$2

echo "Installing docker on vm $VMName"
az vm run-command invoke -g $RESOURCEGROUP -n $VMName --command-id RunShellScript --scripts "sudo apt-get update && sudo apt-get remove -y docker docker-engine docker.io && sudo apt install -y docker.io && sudo systemctl start docker && sudo systemctl enable docker"
echo "Installing azure cli on vm $VMName"
az vm run-command invoke -g $RESOURCEGROUP -n $VMName --command-id RunShellScript --scripts "sudo apt-get update && sudo apt-get install -y ca-certificates curl apt-transport-https lsb-release gnupg && curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null && echo 'deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ bionic main' | sudo tee /etc/apt/sources.list.d/azure-cli.list && sudo apt-get update && sudo apt-get -y install azure-cli"

