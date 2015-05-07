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
interface range fa0/2-5 || S2: fa0/2-17
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


