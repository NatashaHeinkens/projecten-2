##Stappenplan Deelopdracht 5: DHCP##

* Enter the sudo password where asked.
```
sudo yum -y install dhcp
vi /etc/dhcp/dhcpd.conf
```

* In vi, go to input mode and change the config file to the following. Substitute the `group007.be` with your own domain, and the DC-controller’s mac address `08:00:27:64:72:61` with that of your own DC-controller.

```
option domain-name “group007.be”;

option domain-name-servers dhcp.group007.be;

default-lease-time 600;

max-lease-time 7200;

authoritative;

subnet 10.0.2.0 netmask 255.255.255.0 {
	range dynamic-bootp 10.0.2.16 10.0.2.192;
	option broadcast-address 10.0.2.255;
   	option routers 10.0.2.1;
}

host dc {
	option host-name “dc.group007.be”;
	hardware ethernet 08:00:27:64:72:61;
	fixed-address 10.0.2.252;
}
```
* Save the file and exit vi using the appropriate vi commands.
* In the CLI, start the dhcp service with the following commands: 

```
systemctl start dhcpd 
systemctl enable dhcpd 
```

* The dhcp service will automatically start on boot.