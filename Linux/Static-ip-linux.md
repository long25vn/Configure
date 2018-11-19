I have just started testing Ubuntu 18.04 . The first thing I noticed was how different it handles network interfaces. The way Ubuntu manages network interfaces has completely changed.

Have you heard of NetPlan? Probably not, if you have, then you’re a step ahead of many. NetPlan is a new network configuration tool introduced in Ubuntu 17.10 to manage network settings.

It can be used write simple YAML description of the required network interfaces with what they should be configured to do; and it will generate the required configuration for a chosen renderer tool.

This new tool replaces the static interfaces (/etc/network/interfaces) file that had previously been used to configure Ubuntu network interfaces. Now you must use /etc/netplan/*.yaml to configure Ubuntu interfaces.

The new interfaces configuration file now lives in the /etc/netplan directory. There are two renderers. NetworkManager and networkd.

NetworkManager renderer is mostly used on desktop computers and networkd on servers. If you want NetworkManager to control the network interfaces, use NetworkManager as the renderer, otherwise use networkd.

When you use NetworkManager as the renderer, you will use the NetworkManager GUI to manage the interfaces.

Below is a sample file for a network interface using networkd as renderer using DHCP…. Networkd uses the command line to configure the network interfaces.

```
# This file is generated from information provided by
# the datasource.  Changes to it will not persist across an instance.
# To disable cloud-init's network configuration capabilities, write a file
# /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
# network: {config: disabled}

network:
    ethernets:
        enp0s3:
            addresses: []
            dhcp4: true
    version: 2
```
To save your changes, you run the commands below.

`sudo netplan apply`

# Configuring Static IP Addresses With Networkd (Server)

To configure a static IP address using the new NetPlan tool on Ubuntu server, the file should look similar to the content below…

For example you might find a default netplan configuration file in the /etc/netplan directory called 50-cloud-init.yaml with a following content using the networkd deamon to configure your network interface via DHCP…..

`sudo nano /etc/netplan/50-cloud-init.yaml`

Then file should look like this one below:

```
# This file is generated from information provided by
# the datasource.  Changes to it will not persist across an instance.
# To disable cloud-init's network configuration capabilities, write a file
# /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
# network: {config: disabled}

network:
    ethernets:
        enp0s3:
            addresses: []
            dhcp4: true
    version: 2

```
The above is a default networkd redenrer configuration file for a Ubuntu server using DHCP IP configuration…. If you want to setup a static IP address, configure the file as shown below

`sudo nano /etc/netplan/50-cloud-init.yaml`

Then configure IPv4 addresses as shown below… take notes of the format the lines are written…

```
# This file is generated from information provided by
# the datasource.  Changes to it will not persist across an instance.
# To disable cloud-init's network configuration capabilities, write a file
# /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
# network: {config: disabled}

network:
    ethernets:
        enp0s3:
            addresses: [192.168.1.2/24]
            gateway4: 192.168.1.1
            nameservers:
              addresses: [8.8.8.8,8.8.4.4]
            dhcp4: no
    version: 2
```
Exit and save your changes by running the commands below

`sudo netplan apply`

You can add IPv6 addresses line, separated by a comma.. highlighted example below.

```
# This file is generated from information provided by
# the datasource.  Changes to it will not persist across an instance.
# To disable cloud-init's network configuration capabilities, write a file
# /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
# network: {config: disabled}

network:
    ethernets:
        enp0s3:
            addresses: [192.168.1.2/24]
            gateway4: 192.168.1.1
            nameservers:
              [192.168.1.2/24, '2001:1::2/64']
            dhcp4: no
    version: 2
```
Save your changes, apply and you’re done.

Save and apply your changes…

`sudo netplan apply`

`sudo netplan --debug apply`

This is how to set static IP addresses on Ubuntu 18.04 and 18.10 server and desktop… .

For more about NetPlay, visit this site.

# Configure Network Interfaces With NetworkManager

NetworkManager sample configuration file.

```
# Let NetworkManager manage all devices on this system
network:
  version: 2
  renderer: NetworkManager

```
Next, open the network interfaces GUI on Ubuntu to manage the network.

Congratulations! You’ve just successfully configured static IP addresses on Ubuntu servers.

Enjoy!~

### Reboot

