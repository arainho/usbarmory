#!/usr/bin/env bash

# Script to setup usbarmory 

INVENTORY="${2:-production}"
ARMORY_ADDRESS="${1:-10.0.0.1}"
ARMORY_USER="usbarmory"
ARMORY_SSH_KEY="id_rsa_usbarmory"

# remove old entry at know_hosts
ssh-keygen -R "${ARMORY_ADDRESS}" -f ~/.ssh/known_hosts

# create rsa key pair
test -f ~/.ssh/"${ARMORY_SSH_KEY}" || ssh-keygen -t rsa -b 4096 -C "usbarmory" -f ~/.ssh/"${ARMORY_SSH_KEY}"

# check fingerprint
ssh-keyscan "${ARMORY_ADDRESS}" | ssh-keygen -lf -

# copy public key to usbarmory
ssh-copy-id -i "$HOME"/.ssh/"${ARMORY_SSH_KEY}" "${ARMORY_USER}"@${ARMORY_ADDRESS}

# share internet with usbarmory
[ $(uname) == "Darwin" ] && sudo ./scripts/connection_share.sh || echo $(uname) not supported

# apply ansible playbooks
pushd ansible
ansible-galaxy install -r requirements.yml
ansible-playbook site.yml -i "${INVENTORY}"
popd
