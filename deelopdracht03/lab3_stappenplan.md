##Stappenplan Labo 3##

###part 1###

####step 1:####
follow the instructions in the lab document.

$$$$step 2####

###part 2###

####step 1####
* A/B) run configure pc’s:
** windows7:
** control panel -> use search box: “adapter”
** under network and sharing center, click “View network connections”
** Right-click Local Area Network, click properties
** provide administrator information if needed.
** under Networking tab, select IPv4 and click “Properties”
** click “Use following IP address” and enter IP address, subnet mask and default gateway.
* C) open terminal on PC-A and type “ping 192.168.0.3”
** Pings were not successful due to the router not having been configured.

####step 2####
* Enter router terminal emulation software.
* A) type “enable”
* B) type “configure terminal”
* C) type “hostname R1”
* D) type “no ip domain-lookup”
* E) type “enable password class”
* F) type “line con 0”
** type “password cisco”
** type “exit”
* G) type “line vty 0 4”
** type “password cisco”
** type “exit”
* H) type “service password-encryption”
* I) type “banner motd x Warning, unauthorised access is prohibited x
* J) type “int fast 0/0”
** type “ip add”
** type “ip address 192.168.0.1 255.255.255.0”
** type “no shut”
** type “exit”
** type “int fast 0/1”
** type “ip add”
** type “ip address 192.168.1.1 255.255.255.0”
** type “no shut”
** type “exit”
* K) type “int fast 0/0”
** type “description fast 0/0 is connected to PC-B
** type “exit”
** type “int fast 0/1”
** type “description fast 0/1 is connected to switch S1
** type “exit”
* L) type “exit”
** type “copy running-config startup-config”
** this will require confirmation. Simply hit the return key.
* M) type “clock HH/MM/SS DAY MONTH YEAR”
** with HH/MM/SS in numbers of hours/minutes/seconds, DAY in number of day in the month, MONTH by name and YEAR in 4-digit number  (e.g. 14:50:33 03 March 2015)
* N) open terminal on PC-A and type “ping 192.168.0.3”
** Pings are successful. Every device in between is configured.

###Part 3###

####Step 1####
* A) enter the console password on the router.
** type “show version”
*** The IOS image is Version 12.4(15)T1
*** It has 114688Kb/16388Kb DRAM memory.
*** It has 191Kb NVRAM memory.
*** It has 64388Kb flash memory.
* B)  enter the console password on the switch.
** type “show version”
*** The IOS image is Version 12.1(22)EA4
*** It has 21039Kb DRAM memory.
*** It has no NVRAM memory.
*** The model number is WS-C2950-24

####Step 2####

* enter the console password on the router.
** type “show ip route”
*** A directly connected network is shown by the code “C”
*** There are 2 entries with code C
*** FastEthernet is associated with code C

####Step 3####

