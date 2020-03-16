# usbarmory-setup

I order my usbarmory device from [crowdsupply](https://www.crowdsupply.com/inverse-path/usb-armory) to Europe, and after more than one month and paying customs duties, the Armory finally arrived :-)

My purpose is to use the Armory a my password manager with [KeePass](https://keepass.info/),
and also [INTERLOCK](https://github.com/f-secure-foundry/interlock) (file encryption front end).

### 1. Preparing your own microSD card
- 1. check [microSD-compatibility](https://github.com/inversepath/usbarmory/wiki/microSD-compatibility)
- 2. choose one of the [available images](https://github.com/inversepath/usbarmory/wiki/Available-images) for usbarmory.
- 3. [burn](https://github.com/inversepath/usbarmory-debian-base_image#Installing) the image into microSD card 

I choose a Samsung microSD and a pre-compiled release of Debian stretch image available [here](https://github.com/inversepath/usbarmory-debian-base_image/releases).

### 2. Connect to usbarmory

#### Option 1 - serial
The usbarmory serial port can be connected to via a USB to TTL cable; the breakout header can connect as described in [gpio page](https://github.com/inversepath/usbarmory/wiki/GPIOs).

I solder a header in usbarmory and use pins 1,5,6 to connect 'usb to ttl' adapter with silicon CP210x chipset and specific [drivers](https://www.silabs.com/products/development-tools/software/usb-to-uart-bridge-vcp-drivers).
To connect in macOS use the next command:
```
screen /dev/tty.SLAB_USBtoUART 115200
```

#### Option 2 - ssh connection
In this image `usbarmory-debian-base_image` usbarmory cames with predefined ipv4 address `10.0.0.1`, so set you ip address to `10.0.0.2` and connect to your usbarmory. 

Now you can log in with
```
ssh 10.0.0.1 -l usbarmory
```

### 3. Prepare KeePass
Setup is done with Ansible
  - setup ssh
  - install keepass2, etckeeper and common utilities

### 4. INTERLOCK

work in progress

### Notes
WE need the `RNDIS/Ethernet Gadget` interface in the macOS Network Preferences.

To share macOS internet access with the usbarmory device, you can:

option 1
```
sudo ./scripts/connection_share.sh
```

option 2
  - set usbamory ip to `192.168.2.X/24` and gateway `192.168.2.1`
  - in macOS set ip address of `RNDIS/Ethernet Gadget` interface to `192.168.2.1`
  - finally set `Enable Internet Sharing` to ON in System Preferences

