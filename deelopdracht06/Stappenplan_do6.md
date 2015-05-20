##Stappenplan Deelopdracht 6##

###Part 1###

####step 1:####
Follow the instructions in the lab document.

####step 2:####

* Go to network settings, set ip4 address to manual and set addresses, netmasks and default gateways as provided.

####step 3####

#####Router#####
When asked for confirmation, hit the “enter” key.
```
enable
erase startup-config
reload
```
* You will be prompted to save running configuration. Type `no` and hit enter.
* You will be asked to enter the initial configuration dialog. Type `no` and hit enter.
* You will be prompted to terminate the autoinstall. Type `yes` and hit enter.

#####Switches#####
When asked for confirmation, hit the “enter” key.
```
enable
show flash
```
* If there is a vlan.dat file, type `delete vlan.dat` and press enter to confirm.
* If you didn’t have to delete, skip the next steps and go to step 4

####step 4####

* Connect the console cable with the switch and enter the console emulator.
```
enable
cons t
no ip lookup
enable secret class
line con 0
password cisco
login
exit
line vty 0 15
password cisco
login
logging synchronous
exit
service password-encryption
```

* After this for switch 1, enter the following:
```
interface vlan1
ip address 192.168.1.11 255.255.255.0
ip default-gateway 192.168.1.1
interface range fa0/2 - 4
shut
interface range fa0/7 - 24
shut
exit
hostname S1
exit
```
* For switch 2, instead enter this:
```
interface vlan1
ip address 192.168.1.12 255.255.255.0
ip default-gateway 192.168.1.1
interface range fa0/2 - 17
shut
interface range fa0/19 - 24
shut
exit
hostname S2
exit
```
* Note: the end of the range may differ depending on the number of ports on the switch. This guide assumes that you are using a 24-port switch.

* Finish this step on both switches by typing `copy running-config startup-config`

####step 5####

* Connect the console cable with the router and enter the console emulator.
```
enable
cons t
no ip lookup
hostname R1
enable secret class
line con 0
password cisco
login
line vty 0 4
password cisco
login
logging synchronous
interface loopback0
ip address 209.165.200.225 255.255.255.224
exit
copy running-config startup-config
```

###part 2###

####step 1####

* Connect the console cable with S1 and enter the console emulator and enter the configure terminal.
```
vlan 10
name Students
vlan 20
name Faculty
interface f0/1
switchport mode trunk
mdix auto
no shut
interface f0/5
switchport mode trunk
no shut
interface f0/6
switchport mode access
no shut
switchport access vlan 10
end
```
* Note: we include the command `mdix auto` in case you use a normal network calbe instead of a crossover and the switch does not automatically adapt.

####step 2####

* Connect the console cable with S1 and enter the console emulator and enter the configure terminal.
```
vlan 10
name Students
vlan 20
name Faculty
interface f0/1
switchport mode trunk
no shut
interface f0/18
switchport mode trunk
no shut
switchport access vlan 20
end
```

###Part 3###

The following steps can all be done right after each other.

* Connect the console cable with R1 and enter the console emulator and enter the configure terminal.

####Step 1####

```
interface g0/1.1
encapsulation dot1Q 1 
ip address 192.168.1.1 255.255.255.0 
```

####Step 2####

```
interface g0/1.10
encapsulation dot1Q 10 
ip address 192.168.10.1 255.255.255.0 
```

####Step 3####

```
interface g0/1.20
encapsulation dot1Q 20 
ip address 192.168.20.1 255.255.255.0 
```

####Step 4####

```
interface g0/1
no shut
```

####Step 5####

* On PC-A in the CLI, type `ping 192.168.10.1`
* On PC-A in the CLI, type `ping 192.168.20.3`
* On PC-A in the CLI, type `ping 209.165.200.225`
* On PC-A in the CLI, type `ping 192.168.1.12`
