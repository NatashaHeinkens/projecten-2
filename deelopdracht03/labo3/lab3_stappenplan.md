##Stappenplan Labo 3##

###part 1###

####step 1:####
Follow the instructions in the lab document.

####step 2####
See Appendix B


###part 2###

####step 1####
* A/B) Run configure pc’s:
 * Windows7:
 * Control panel -> use search box: “adapter”
 * Under network and sharing center, click “View network connections”
 * Right-click Local Area Network, click properties
 * Provide administrator information if needed.
 * Under Networking tab, select IPv4 and click “Properties”
 * Click “Use following IP address” and enter IP address, subnet mask and default gateway.
* C) Open terminal on PC-A and type “ping 192.168.0.3”
 * Pings were not successful due to the router not having been configured.

####step 2####
Also, see Appendix A.
* Enter router terminal emulation software.
* A) Type “enable”
* B) Type “configure terminal”
* C) Type “hostname R1”
* D) Type “no ip domain-lookup”
* E) Type “enable password class”
* F) Type “line con 0”
 * Type “password cisco”
 * Type “exit”
* G) Type “line vty 0 4”
 * Type “password cisco”
 * Type “exit”
* H) Type “service password-encryption”
* I) Type “banner motd x Warning, unauthorised access is prohibited x
* J) Type “int fast 0/0”
 * Type “ip add”
 * Type “ip address 192.168.0.1 255.255.255.0”
 * Type “no shut”
 * Type “exit”
 * Type “int fast 0/1”
 * Type “ip add”
 * Type “ip address 192.168.1.1 255.255.255.0”
 * Type “no shut”
 * Type “exit”
* K) Type “int fast 0/0”
 * Type “description fast 0/0 is connected to PC-B
 * Type “exit”
 * Type “int fast 0/1”
 * Type “description fast 0/1 is connected to switch S1
 * Type “exit”
* L) Type “exit”
 * Type “copy running-config startup-config”
 * This will require confirmation. Simply hit the return key.
* M) Type “clock HH/MM/SS DAY MONTH YEAR”
 * With HH/MM/SS in numbers of hours/minutes/seconds, DAY in number of day in the month, MONTH by name and YEAR in 4-digit number  (e.g. 14:50:33 03 March 2015)
* N) Open terminal on PC-A and type “ping 192.168.0.3”
 * Pings are successful. Every device in between is configured.

###Part 3###

####Step 1####
* A) Enter the console password on the router.
 * Type “show version”
  * The IOS image is Version 12.4(15)T1
  * It has 114688Kb/16388Kb DRAM memory.
  * It has 191Kb NVRAM memory.
  * It has 64388Kb flash memory.
* B) Enter the console password on the switch.
 * Type “show version”
  * The IOS image is Version 12.1(22)EA4
  * It has 21039Kb DRAM memory.
  * (cannot find any NVRAM in the information given).
  * The model number is WS-C2950-24

####Step 2####

* Enter the console password on the router.
 * Type “show ip route”
  * A directly connected network is shown by the code “C”
  * There are 2 entries with code C
  * FastEthernet is associated with code C

####Step 3####

* Enter the console password on the router.
 * Type “show interface fastethernet0/1
  * The Operational status is up (connected)
  * The MAC address of G0/1 is 0040.0b12.1402
  * The internet address is displayed in CIDR notation: 192.168.1.1/24

####Step 4####

* Enter the console password on the router.
 * Type “show ip interface brief”.
* Access the switch’s terminal emulation software and type “show ip interface brief”.

Reflection:
1. “no shutdown”
2. nothing changes. The address was not in use.