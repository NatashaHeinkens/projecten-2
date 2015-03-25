# Rapport Labo 3 #

## Simulation ##

### part 1 ###

#### step 1: ####
Follow the instructions in the lab document.

#### step 2 ####
See Appendix B


### part 2 ###

#### step 1 ####
* A/B: follow the instructions in the “stappenplan”.
* C) Open terminal on PC-A and type “ping 192.168.0.3”
 * Pings were not successful due to the router not having been configured.

#### step 2 ####

* A to M: follow the instructions in the “stappenplan”
* N) Open terminal on PC-A and type “ping 192.168.0.3”
 * Pings are successful. Every device in between is configured.

### Part 3 ###

#### Step 1 ####
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

#### Step 2 ####

* Enter the console password on the router.
 * Type “show ip route”
  * A directly connected network is shown by the code “C”
  * There are 2 entries with code C
  * FastEthernet is associated with code C

#### Step 3 ####

* Enter the console password on the router.
 * Type “show interface fastethernet0/1
  * The Operational status is up (connected)
  * The MAC address of G0/1 is 0040.0b12.1402
  * The internet address is displayed in CIDR notation: 192.168.1.1/24

#### Step 4 ####

* Enter the console password on the router.
 * Type “show ip interface brief”.
* Access the switch’s terminal emulation software and type “show ip interface brief”.

Reflection:
1. If the G0/1 interface showed administratively down, what interface configuration command would you use to turn the interface up?
 * “no shutdown”
2. What would happen if you had incorrectly configured interface G0/1 on the router with an IP address of 192.168.1.2?
 * nothing changes. The address was not in use.

## Physical ##