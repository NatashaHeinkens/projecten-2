# Verslag Labo 3 #

## Simulation ##

### Part 1 ###

#### Step 1: ####
Follow the instructions in the lab document.

#### Step 2 ####
See Appendix B


### Part 2 ###

#### Step 1 ####
* A/B: follow the instructions in the “stappenplan”.
* C) Open terminal on PC-A and type `ping 192.168.0.3`
 * Pings were not successful due to the router not having been configured.

#### Step 2 ####

* A to M: follow the instructions in the “stappenplan”
* N) Open terminal on PC-A and type `ping 192.168.0.3`
 * Pings are successful. Every device in between is configured.

### Part 3 ###

#### Step 1 ####
* A) Enter the console password on the router.
 * Type `show version`
  * The IOS image is Version 12.4(15)T1
  * It has 114688Kb/16388Kb DRAM memory.
  * It has 191Kb NVRAM memory.
  * It has 64388Kb flash memory.
* B) Enter the console password on the switch.
 * Type `show version`
  * The IOS image is Version 12.1(22)EA4
  * It has 21039Kb DRAM memory.
  * (cannot find any NVRAM in the information given).
  * The model number is WS-C2950-24

#### Step 2 ####

* Enter the console password on the router.
 * Type `show ip route`
  * A directly connected network is shown by the code “C”
  * There are 2 entries with code C
  * FastEthernet is associated with code C

#### Step 3 ####

* Enter the console password on the router.
 * Type `show interface fastethernet0/1`
  * The Operational status is up (connected)
  * The MAC address of G0/1 is 0040.0b12.1402
  * The internet address is displayed in CIDR notation: 192.168.1.1/24

#### Step 4 ####

* Enter the console password on the router.
 * Type `show ip interface brief”`
* Access the switch’s terminal emulation software and type `show ip interface brief”`

Reflection:

1. If the G0/1 interface showed administratively down, what interface configuration command would you use to turn the interface up?
 * `no shutdown`
2. What would happen if you had incorrectly configured interface G0/1 on the router with an IP address of 192.168.1.2?
 * nothing changes. The address was not in use.

## Physical ##

For one of the PC’s, instead of the recommended OS of Windows 7, vista or XP we used a portable Linux Fedora 7 booted from a cd provided to us by Mr Van Vreckem after we concluded we could not modify the network settings on the class pc's without administrator access. In Fedora, we accessed the router and switch terminals from it directly through Fedora’s terminal with the command `screen /dev/ttyS0` after installing the “screen” application through executing `sudo yum install screen`.

### Part 1 ###

#### Step 1 ####

We followed the topology diagram and set up and cabled the 2 pc’s, the router and the switch as shown. Additionally, we used a console cable to connect the router and the switch to one of the pc’s as was needed to configure them (if the report talks about configuring either of these devices, it is assumed the console cable is connected to that device at the time).

#### Step 2 ####

As per Appendix B of the lab, we reset the router by using the commands `enable`, `erase startup-config` and `reload` in that order on the router. 

![Image resetting router] ( https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht03/labo3/screenshots/router_reset.png "resetting router")

By checking the switch with the `show flash` command, we concluded that it did not need to be reset since there was no VLAN file.

![Image resetting switch] ( https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht03/labo3/screenshots/switch_reset.png "resetting switch")

### Part 2 ###

#### Step 1 ####

Since we did not use the OS used in the stappenplan for one of the pc’s, we deviated slightly from it. Instead, we opened the network settings directly through the settings menu in the top right corner of the screen, set the IP address, subnet mask and default gateway after enabling static IP use. The other pc was set up as was described.

The pinging PC B from PC A did not work because the router had not yet been properly configured.

#### Step 2 ####

We followed the instructions of the lab as per Appendix A Step 2.

When we tried to ping, we were unsuccessful. First, we ran into some troubles as the G0/1 port had not been given the no shut command and did not show up on the routing tables. After this was remedied we had a defective cable which was then replaced, allowing us to ping from PC B to G0/1 and from PC A to G0/0.

We still could not ping from PC A to PC B or the other way around. First, we had to disable PC B’s wifi, as it used the wifi as default gateway instead of the one we had configured in its network settings.

Another problem rose up as we concluded that PC A’s network settings would not properly be configured through the settings menu, and we used the commands `ip route add default via 192.168.1.1 dev em1` and `ip addr add 192.168.1.3/24 dev em1` to respectively add the default gateway and the IP address and subnet mask, with the /24 being the CIDR notation for the subnet mask 255.255.255.0.

After that we had to disable both pc’s firewalls as they one-sidedly blocked pinging: With PC A’s firewall down, PC B could successfully ping to PC A, but PC A could not ping to PC B. This could also be remedied by allowing pings through the firewall.

### Part 3 ###

#### Step 1 ####

We used the `show version` command to request the required information about the router.

![Image show version router] ( https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht03/labo3/screenshots/show_version_router.png "show version router")

* What is the name of the IOS image that the router is running?
 * Cisco IOS Software, 2801 Software (C2801-IPBASE-M), Version 12.4(18b), RELEASE SOFTWARE (fc2)
* How much DRAM memory does the router have?
 * 64 bits.
* How much NVRAM memory does the router have?
 * 191 Kb.
* How much Flash memory does the router have?
 * 62720 Kb.

After this, we used the `show version` command on the switch.

![Image show version switch] ( https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht03/labo3/screenshots/show_version_switch.png "show version switch")

* What is the name of the IOS image that the switch is running?
 * Cisco IOS Software, 2960S Software (C2960S-UNIVERSAL-M), Version 12.2(53)SE2, RELEASE SOFTWARE (fc3)
* How much dynamic random access memory (DRAM) does the switch have?
 * 
* How much nonvolatile random-access memory (NVRAM) does the switch have?
 * 
* What is the model number of the switch?
 * 

#### Step 2 ####

We used the `show ip route` command on the router.

![Image show ip route] ( https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht03/labo3/screenshots/show_ip_route.png "show ip route")

* What code is used in the routing table to indicate a directly connected network?
 * "C".
* How many route entries are coded with a C code in the routing table?
 * Two, both FastEthernet 0/0 and FastEthernet 0/1
* What interface types are associated to the C coded routes?
 * FastEthernet.


#### Step 3 ####

We used the `show interface g0/1` command on the router.

![Image show interface g0/1] ( https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht03/labo3/screenshots/show_interface_g01.png "show interface g0/1")

* What is the operational status of the G0/1 interface?
 * The G0/1 interface is "up".
* What is the Media Access Control (MAC) address of the G0/1 interface?
 * The MAC address is "0022.55a1.924b"
* How is the Internet address displayed in this command?
 * In the CIDR notation: "192.168.1.1/24"

#### Step 4 ####

We used the `show interface brief` command on the router.

![Image show interface briefrouter] ( https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht03/labo3/screenshots/show_ip_interface_brief_router.png "show interface brief router")

After this, we used the `show interface brief` command on the switch.

![Image show interface brief switch] ( https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht03/labo3/screenshots/show_ip_interface_brief_switch.png "show interface brief switch")

##### Reflection #####

* If the G0/1 interface showed administratively down, what interface configuration command would you use to turn the interface up?

We would navigate to the interface’s configuration through the following commands:
```
enable
configure terminal
int fast 0/1
```
And then we would run the `no shut` command.

* What would happen if you had incorrectly configured interface G0/1 on the router with an IP address of 192.168.1.2?

This would not affect the network setup, as 192.168.1.2 is a valid IP address.
