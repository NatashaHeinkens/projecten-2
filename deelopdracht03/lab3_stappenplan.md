—PART 1—

STEP 1:
follow the instructions in the lab document.

STEP 2:

—PART 2—

STEP 1:
A/B) run configure pc’s:
windows7:
control panel -> use search box: “adapter”
under network and sharing center, click “View network connections”
Right-click Local Area Network, click properties
provide administrator information if needed.
under Networking tab, select IPv4 and click “Properties”
click “Use following IP address” and enter IP address, subnet mask and default gateway.
C) open terminal on PC-A and type “ping 192.168.0.3”
Pings were not successful due to the router not having been configured

STEP 2:
Enter router terminal emulation software.
A) type “enable”
B) type “configure terminal”
C) type “hostname R1”
D) type “no ip domain-lookup”
E) type “enable password class”
F) type “line con 0”
	type “password cisco”
	type “exit”
G) type “line vty 0 4”
	type “password cisco”
	type “exit”
H) type “service password-encryption”
I) type “banner motd x Warning, unauthorised access is prohibited x
J) type “int fast 0/0”
	type “ip add”
	type “ip address 192.168.0.1 255.255.255.0”
	type “no shut”
	type “exit”
	type “int fast 0/1”
	type “ip add”
	type “ip address 192.168.1.1 255.255.255.0”
	type “no shut”
	type “exit”
K) type “int fast 0/0”
	type “description fast 0/0 is connected to PC-B
	type “exit”
	type “int fast 0/1”
	type “description fast 0/1 is connected to switch S1
	type “exit”
L) type “exit”
	type “copy running-config startup-config”
	this will require confirmation. Simply hit the return key.
M) type “clock HH/MM/SS DAY MONTH YEAR”
with HH/MM/SS in numbers of hours/minutes/seconds, DAY in number of day in the month, MONTH by name and YEAR in 4-digit number  (e.g. 14:50:33 03 March 2015)
N) open terminal on PC-A and type “ping 192.168.0.3”
Pings are successful. Every device in between is configured.

—PART 3—