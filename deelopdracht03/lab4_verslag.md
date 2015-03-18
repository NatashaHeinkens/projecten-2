###Taak 1
1. Keuze van apparaten: zie typenamen onder elk toestel in de topologie.
2. Serial interfaces toevoegen aan routers  
   1. router uitzetten: klikken op 1/0-knop in de afbeelding van de achterkant van de router
   2. module HWIC-2T toevoegen in rechterslot: sleep de module uit de lijst links naar de rechterslot in de afbeelding
3. Links:
   * Copper straight-through voor alles behalve de serial links (roodgekleurde lijnen in de topologie)
   * Voor de serial links: Serial DCE

###Taak 2: Basisconfiguratie

De gegeven commando's zijn voor R1, voor de andere routers verloopt het volledig analoog.

**Stap 1**  
```
enable
conf t 
hostname R1 
no ip domain-l
enable secret cisco
```
**Stap 2**  
```
line cons 0
pass letmein
login

line vty 0 4
pass letmein
```
**Stap 3**  
```
line cons 0
logg syn
line vty 0 4
log syn
```
**Stap 4**  
```
line cons 0
exe 0 0
line vty 0 4
exe 0 0

end (=> terug naar privileged EXEC)
```
###Taak 3: Debug Output

**Stap 1**  

`deb ip ro`

**Stap 2**  
```
conf t
int fa 0/0
ip address 172.16.3.1 255.255.255.0
```
**Stap 3**  

`no shutdown`

**Stap 4**  
```
end
show ip route
```
**Stap 5**  
```
conf t
int s 0/0/0
ip address 172.16.2.1 255.255.255.0
```
**Stap 6**  

`clock rate 64000`

**Stap 7**  

`no shutdown`

Stap 8 en 9: zie stap 5 en stap 7 (met juiste ip cf. tabel bovenaan)

**Stap 10**  
```
end
show ip route
```
**Stap 11**  

`no debug ip routing`

###Taak 4: Configuratie vervolledigen
Analoog aan taak 3, no shutdown niet vergeten

###Taak 5: hosts configureren
Klik op de host > Desktop > IP configuration

###Taak 6: Connectiviteit testen en configuratie verifiëren

**Stap 1**  
Klik op de host > Desktop > Command Prompt en voer ping-commando uit

**Stap 2**  
Voer ping-commando uit in user EXEC of privileged EXEC

**Stap 3**  
Ping faalt omdat de routers alleen de netwerken kennen die rechtstreeks met 1 van hun interfaces verbonden zijn

###Taak 7: Informatie verzamelen

**Stap 1**  
Commando `show ip int br` in user EXEC of privileged EXEC

**Stap 2**  
Commando `show ip route` in user EXEC of privileged EXEC
De routers hebben alleen routes voor de netwerken die rechtstreeks met 1 van hun interfaces verbonden zijn

###Taak 8: Configuratie static routes door opgave van next hop

**Stap 1**  
op R3, in global config:
`ip route 172.16.1.0 255.255.255.0 192.168.1.2`

**Stap 2**  
Fout in opgave forwardbeslissingen R3? Packet 5: 192.16.2.10 moet zijn: 192.168.2.10

**Stap 3**  
op PC3: ping 172.16.1.10

**Stap 4**  
Op R2 in global config:
`ip route 192.168.2.0 255.255.255.0 192.168.1.1`

**Stap 5**  
Op R2 in user EXEC of privileged EXEC:
`show ip route`

**Stap 6**  
zie stap 3

###Taak 9: Configuratie static routes door opgave van een exit interface

**Stap 1**  
op R3, in global config:
`ip route 172.16.2.0 255.255.255.0 Serial 0/0/1`

**Stap 2**  
```
exit
sho ip ro
sho run
```
**Stap 3**  
`R2(config)#ip route 172.16.3.0 255.255.255.0 Serial 0/0/0`

**Stap 4**  
```
R2(config)#exit
R2#
%SYS-5-CONFIG_I: Configured from console by console

R2#sho ip ro
Codes: C - connected, S - static, I - IGRP, R - RIP, M - mobile, B - BGP
       D - EIGRP, EX - EIGRP external, O - OSPF, IA - OSPF inter area
       N1 - OSPF NSSA external type 1, N2 - OSPF NSSA external type 2
       E1 - OSPF external type 1, E2 - OSPF external type 2, E - EGP
       i - IS-IS, L1 - IS-IS level-1, L2 - IS-IS level-2, ia - IS-IS inter area
       * - candidate default, U - per-user static route, o - ODR
       P - periodic downloaded static route

Gateway of last resort is not set

     172.16.0.0/24 is subnetted, 3 subnets
C       172.16.1.0 is directly connected, FastEthernet0/0
C       172.16.2.0 is directly connected, Serial0/0/0
S       172.16.3.0 is directly connected, Serial0/0/0
C    192.168.1.0/24 is directly connected, Serial0/0/1
S    192.168.2.0/24 [1/0] via 192.168.1.1
```

**Stap 5**  
Op PC2: `ping 172.16.3.10`

###Taak 10: Configuratie default static route

**Stap 1 en 2**  
```
R1(config)#ip route 0.0.0.0 0.0.0.0 172.16.2.2
R1(config)#exit
R1#
%SYS-5-CONFIG_I: Configured from console by console

R1#sho ip ro
Codes: C - connected, S - static, I - IGRP, R - RIP, M - mobile, B - BGP
       D - EIGRP, EX - EIGRP external, O - OSPF, IA - OSPF inter area
       N1 - OSPF NSSA external type 1, N2 - OSPF NSSA external type 2
       E1 - OSPF external type 1, E2 - OSPF external type 2, E - EGP
       i - IS-IS, L1 - IS-IS level-1, L2 - IS-IS level-2, ia - IS-IS inter area
       * - candidate default, U - per-user static route, o - ODR
       P - periodic downloaded static route

Gateway of last resort is 172.16.2.2 to network 0.0.0.0

     172.16.0.0/24 is subnetted, 2 subnets
C       172.16.2.0 is directly connected, Serial0/0/0
C       172.16.3.0 is directly connected, FastEthernet0/0
S*   0.0.0.0/0 [1/0] via 172.16.2.2
```

**Stap 3**  
Op PC2: ping 172.16.3.10
Op PC3: ping 172.16.3.10

###Taak 11: Configuratie summary static route

**Stap 1 en 2**  
``` 
R3#conf t
Enter configuration commands, one per line.  End with CNTL/Z.
R3(config)#ip route 172.16.0.0 255.255.252.0 192.168.1.2
R3(config)#exit
R3#
%SYS-5-CONFIG_I: Configured from console by console

R3#sho ip ro
Codes: C - connected, S - static, I - IGRP, R - RIP, M - mobile, B - BGP
       D - EIGRP, EX - EIGRP external, O - OSPF, IA - OSPF inter area
       N1 - OSPF NSSA external type 1, N2 - OSPF NSSA external type 2
       E1 - OSPF external type 1, E2 - OSPF external type 2, E - EGP
       i - IS-IS, L1 - IS-IS level-1, L2 - IS-IS level-2, ia - IS-IS inter area
       * - candidate default, U - per-user static route, o - ODR
       P - periodic downloaded static route

Gateway of last resort is not set

     172.16.0.0/16 is variably subnetted, 3 subnets, 2 masks
S       172.16.0.0/22 [1/0] via 192.168.1.2
S       172.16.1.0/24 [1/0] via 192.168.1.2
S       172.16.2.0/24 is directly connected, Serial0/0/1
C    192.168.1.0/24 is directly connected, Serial0/0/1
C    192.168.2.0/24 is directly connected, FastEthernet0/0
```

**Stap 3 en 4**  
Fout in opgave? Static route via interface Serial0/0/0 bestaat niet (+ op deze interface is niets aangesloten), wel via Serial0/0/1

```
R3#conf t
Enter configuration commands, one per line.  End with CNTL/Z.
R3(config)#no ip route 172.16.1.0 255.255.255.0 192.168.1.2
R3(config)#no ip route 172.16.2.0 255.255.255.0 Serial0/0/1
R3(config)#exit
R3#
%SYS-5-CONFIG_I: Configured from console by console

R3#sho ip ro
Codes: C - connected, S - static, I - IGRP, R - RIP, M - mobile, B - BGP
       D - EIGRP, EX - EIGRP external, O - OSPF, IA - OSPF inter area
       N1 - OSPF NSSA external type 1, N2 - OSPF NSSA external type 2
       E1 - OSPF external type 1, E2 - OSPF external type 2, E - EGP
       i - IS-IS, L1 - IS-IS level-1, L2 - IS-IS level-2, ia - IS-IS inter area
       * - candidate default, U - per-user static route, o - ODR
       P - periodic downloaded static route

Gateway of last resort is not set

     172.16.0.0/22 is subnetted, 1 subnets
S       172.16.0.0 [1/0] via 192.168.1.2
C    192.168.1.0/24 is directly connected, Serial0/0/1
C    192.168.2.0/24 is directly connected, FastEthernet0/0
```

**Stap 5**  
Op PC3: `ping 172.16.3.10`
