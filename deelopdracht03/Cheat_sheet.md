// Als je een handige commando ofzo vindt, plaats ze dan maar hier. Als iedereen klaar is met zijn labo dan zal dit bestandje herwerkt worden naar een deftig verslag.

###Gebruikersmodi

* `enable`: om in de privileged EXEC mode te gaan
* `conf t` (`configure terminal`): om in global configuration mode te gaan (vanuit privileged EXEC)
* `line console 0`: configureren van consoleverbinding (0)
* `line vty 0 4`: configureren van virtual tty lines 0 t.e.m. 4 (Telnettoegang)
* `interface s 0/0/0`, `interface fa 0/0`: configureren van Serial interface resp. FastEthernet interface (nummer interface invullen)

###Systeeminformatie tonen

* `show version`: om systeem versie(IOS) te tonen
* `show ip interface brief` (user EXEC of privileged EXEC: toont een overzicht van alle interfaces op het apparaat
* `show ip route` (user EXEC of privileged EXEC: toont de routeringstabel
* `show running-config` (privileged EXEC): toont volledige configuratie (zijn paswoorden geëncrypteerd, voor welke toegangen moet je inloggen, configuratie interfaces, static routes,...)  
   Let op! Als paswoorden niet geëncrypteerd zijn, zijn ze hier zichtbaar!
* `show vlan brief` (privileged EXEC): toont overzicht van VLAN-informatie
   
###Algemene instellingen

* `no ip domain-lookup` (privileged EXEC): zéér handig om te verhinderen dat het apparaat verkeerd ingegeven commando's (meer specifiek: alles dat geen keyword is) probeert om te zetten in een ip-adres
* `enable secret xx` (global config): privileged EXEC beveiligen met een geëncrypteerd paswoord
* `enable password xx` (global config): privileged EXEC 'beveiligen' met een **niet-geëncrypteerd** paswoord
* `service password-encryption` (global config): niet-geëncrypteerde paswoorden in de configbestanden encrypteren (zorgt er **niet** voor dat paswoorden geëncrypteerd worden **verzonden** i.g.v. remote access)
* `password xx` (in line config mode): toegang tot de line beveiligen met een **niet-geëncrypteerd** paswoord  
   Vergeet hierna paswoordencryptie niet aan te zetten!
* `login` (in line config mode): vereisen dat het paswoord wordt ingegeven voor toegang tot een line

###Klokinstellingen

* `show clock`: om de huidige ingestelde klok te zien
* `clock set ?` : om de klok in te stellen adhv '?' wat een verwachte waarde zal generen

###Configuratie netwerkinterfaces
Vergeet na het configureren het `no shutdown` commando niet om de interface + instellingen te activeren!

* `ip address 192.168.0.1 255.255.0.0`: ip-adres en subnetmask van een interface instellen (ip en netmask invullen)
* `no shutdown`: interface + instellingen activeren

###Configuratie routering

####Static route door opgave van next hop
`ip route 172.16.1.0 255.255.255.0 192.168.1.2` (global config):

* het eerste ip-adres is het netwerkadres van het doelnetwerk
* de subnetmask is de netmask van het doelnetwerk
* het laatste ip-adres: naar dit adres (de next hop) moeten pakketten geadresseerd aan het doelnetwerk worden doorgestuurd

####Static route door opgave van exit interface
`ip route 172.16.2.0 255.255.255.0 Serial 0/0/1` (global config): 

* het eerste ip-adres is het netwerkadres van het doelnetwerk
* de subnetmask is de netmask van het doelnetwerk
* de interface: langs deze interface moeten pakketten geadresseerd aan het doelnetwerk worden doorgestuurd

####Default static route
Dit komt overeen met het opgeven van een default gateway voor de router. Alle pakketten die bestemd zijn voor netwerken die de router niet kent, worden langs deze route doorgestuurd.

`ip route 0.0.0.0 0.0.0.0 172.16.2.2` (global config)

####Summary static route
Meerdere doelnetwerken, die qua netwerkadres/subnet dicht bij elkaar liggen, 'samenvatten' in 1 route.

Voorbeeld: doelnetwerken 172.16.2.0/24 and 172.16.1.0/24  
Werkwijze:

1. zet de netwerkadressen om in hun binaire vorm en bepaal het gemeenschappelijk gedeelte (identieke cijfers vooraan te beginnen)
2. het aantal bits dat in het netwerkgedeelte van het adres hetzelfde is (stap 1) levert de subnetmask -> voorbeeld: 22 bits, dus subnetmask 255.255.252.0
3. alle bits rechts van het gemeenschappelijk gedeelte op 0 zetten levert het doelnetwerkadres -> voorbeeld: 172.16.0.0

`ip route 172.16.0.0 255.255.252.0 192.168.1.2` (global config):
