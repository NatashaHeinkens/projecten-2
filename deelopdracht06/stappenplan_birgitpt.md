Heel kort, ter referentie voor jullie in Gent, alle stappen in Packet Tracer

##Deel 1

###Stap 1

![alt] (/deelopdracht06/lab5137_files/pt_topologie.png "Topologie in Packet Tracer")

###Stap 2

![alt] (/deelopdracht06/lab5137_files/pt_pcs.png "IP-configuratie PC's")

###Stap 3

Router
```
enable
erase startup-config
reload
no
```

Switches
```
enable
show flash
##Als vlan.dat voorkomt in de weergave van het flash-geheugen:
delete vlan.dat
##
erase startup-config
reload
```

###Stap 4

Switches
```
##global config binnengaan
no ip domain-lookup

hostname S1 || S2
enable secret class

line con 0
password cisco
login
logging synchronous

line vty 0 4 
password cisco

interface vlan 1
ip address 192.168.1.11 255.255.255.0 || S2: 192.168.1.12
no shutdown
exit

ip def 192.168.1.1
interface range fa0/2-4 || S2: fa0/2-17
shutdown
interface range fa0/7-24 || S2: fa0/19/24
shutdown
interface range g0/1-2
shutdown

exit
service password-encryption

end
copy run sta
```

###Stap 5
Router
```
##global config binnengaan

no ip domain-lookup
hostname R1
enable secret class

line con 0
password cisco
login
logging synchronous

line vty 0 4
password cisco

exit
service password-encryption

interface Lo 0
ip address 209.165.200.225 255.255.255.0

end
copy run sta
```

##Deel 2

###Stap 1

Switch S1
```
User Access Verification

Password: 

S1>enable
Password: 
S1#conf t
Enter configuration commands, one per line.  End with CNTL/Z.
S1(config)#vlan 10
S1(config-vlan)#name Students
S1(config-vlan)#vlan 20
S1(config-vlan)#name Faculty
S1(config-vlan)#exit

S1(config)#interface f0/1
S1(config-if)#switchport mode trunk

S1(config-if)#
%LINEPROTO-5-UPDOWN: Line protocol on Interface FastEthernet0/1, changed state to down

%LINEPROTO-5-UPDOWN: Line protocol on Interface FastEthernet0/1, changed state to up

S1(config-if)#int f0/5
S1(config-if)#switchport mode trunk 
S1(config-if)#int f0/6
S1(config-if)#switchport mode access 
S1(config-if)#switchport access vlan 10
```

###Stap 2
Switch S2
```
User Access Verification

Password: 

S2>enable
Password: 
S2#conf t
Enter configuration commands, one per line.  End with CNTL/Z.
S2(config)#vlan 10
S2(config-vlan)#name Students
S2(config-vlan)#vlan 20
S2(config-vlan)#name Faculty
S2(config-vlan)#int f0/1
S2(config-if)#swi m tr
S2(config-if)#int f0/18
S2(config-if)#sw m a
S2(config-if)#sw a vlan 20
S2(config-if)#
```

##Deel 3

###Stap 1
Router
```
User Access Verification

Password: 

R1>enable
Password: 

R1#conf t
Enter configuration commands, one per line.  End with CNTL/Z.
R1(config)#int g0/1.1
R1(config-subif)#enc dot 1
R1(config-subif)#ip addr 192.168.1.1 255.255.255.0
R1(config-subif)#
```

###Stap 2

```
R1(config-subif)#int g0/1.10
R1(config-subif)#enc dot 10
R1(config-subif)#ip addr 192.168.10.1 255.255.255.0
```

###Stap 3

```
R1(config-subif)#int g0/1.20
R1(config-subif)#enc dot 20
R1(config-subif)#ip addr 192.168.20.1 255.255.255.0
```

###Stap 4

```
R1(config-subif)#exit
R1(config)#int g0/1
R1(config-if)#no shutdown

R1(config-if)#
%LINK-5-CHANGED: Interface GigabitEthernet0/1, changed state to up

%LINK-5-CHANGED: Interface GigabitEthernet0/1.1, changed state to up

%LINK-5-CHANGED: Interface GigabitEthernet0/1.10, changed state to up

%LINK-5-CHANGED: Interface GigabitEthernet0/1.20, changed state to up
```

###Stap 5

```

```