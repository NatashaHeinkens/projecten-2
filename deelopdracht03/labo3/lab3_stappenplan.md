##Stappenplan Labo 3##

###part 1###

####step 1:####
Follow the instructions in the lab document.

####step 2####
See Appendix B

###part 2###

####step 1####
* A) Run configure pc’s:
 * Windows7:
 * Control panel -> use search box: “adapter”
 * Under network and sharing center, click “View network connections”
 * Right-click Local Area Network, click properties
 * Provide administrator information if needed.
 * Under Networking tab, select IPv4 and click “Properties”
 * Click “Use following IP address” and enter the given IP address, subnet mask and default gateway.
* B) Repeat as above

* C) Open terminal on PC-A and type:

`ping 192.168.0.3`

####step 2####
Also, see Appendix A.
* Enter router terminal emulation software and type the following:
```
enable
configure terminal
hostname R1
no ip domain-lookup
enable password class
line con 0
password cisco
exit
line vty 0 4
password cisco
exit
service password-encryption
banner motd x Warning, unauthorised access is prohibited x
int fast 0/0
ip add
ip address 192.168.0.1 255.255.255.0
no shut
exit
int fast 0/1
ip add
ip address 192.168.1.1 255.255.255.0
no shut
exit
int fast 0/0
description fast 0/0 is connected to PC-B
exit
int fast 0/1
description fast 0/1 is connected to switch S1
exit
exit
copy running-config startup-config
```
* This will require confirmation. Simply hit the return key.

`clock HH/MM/SS DAY MONTH YEAR`

 * With HH/MM/SS in numbers of hours/minutes/seconds, DAY in number of day in the month, MONTH by name and YEAR in 4-digit number  (e.g. 14:50:33 03 March 2015)

* Open the terminal on PC-A

`ping 192.168.0.3`

###Part 3###
The required information for each step will become visible after entering the given command(s)

####Step 1####
* A) Enter the console password on the router.

`show version`

* B) Enter the console password on the switch.

`show version`

####Step 2####

* Enter the console password on the router.

`show ip route`

####Step 3####

* Enter the console password on the router.

`show interface fastethernet0/1`

####Step 4####

* Enter the console password on the router.

`show ip interface brief`

* Access the switch’s terminal emulation software.

`show ip interface brief`
