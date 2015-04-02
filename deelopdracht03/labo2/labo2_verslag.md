##Verslag uitvoering labo 2

1. Opzetten fysieke topologie
  * PC A is verbonden met Switch1 met een UTP straight-through kabel, in poort 0/6 van de switch
  * Switch1 is verbonden met Switch2 met een UTP crossed kabel, in poort 0/1 van de switches
  * PC B is verbonden met Switch2 met een UTP straight-through kabel, in poort 0/18 van de switch

2. Configuratie Windows-host (PC-B)

**Netwerkinstellingen
Open Network Connections > Ethernetverbinding > Properties 
Klik in de lijst op `Internet Protocol Version 4` > onder de lijst op Properties

Radio button: Use the following IP address
IP address: 192.168.1.11
Subnet mask: 255.255.255.0

Klik op OK > Klik op Close
Let op! Zolang je de IP-instellingen niet expliciet aanvaard hebt door op OK én Close te klikken, is het ip niet ingesteld!

![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht03/labo2/screens/ip_PCB.png "IP configuratie PCB")

**Pingen
Zet Windows Firewall uit: Control Panel > Windows Firewall > Turn Windows Firewall on or off > Turn off Windows Firewall voor public en private networks

3. Configuratie Linux-host (PC-A)

Daar we geen administratie-rechten hebben onder windows op de klas-pc's, hebben we ook een Linux klas-pc gebruikt. De configuratie daarvan volgt.

**Netwerkinstellingen

  * Klik in de rechterbovenhoek van het scherm op het pijltje naar beneden
  * Klik in het menu'tje dat open, op het instellingen-icoontje (scroevendraaier en steeksleutel)
  * Kies in het 'all settings' menu, kies voor Network (icoon met drie schermen)
  * In het Network-menu, klik op het instellingen-iccontje (tandwiel)
  * Klik in de lijst links op 'IPv4'
  * Naast addresses, kies voor Manual i.p.v. Automatic(DHCP)
  * Voer het juiste adres en subnetmask in.

![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht03/labo2/screens/ip-PCA00.png "All settings")
![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht03/labo2/screens/ip-PCA02.png "Network")
![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht03/labo2/screens/ip-PCA03.png "Wired")
![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht03/labo2/screens/ip-PCA04.png "IPv4")


4. Snelle test (ping)
  * Vanop de terminal (Linux) of command prompt (Windows), voer ping 192.168.1.[10 of 11] uit.
   * Merk op dat je hier het juiste ip kiest, dus hetgene van de andere pc dan degene waarop je werkt (10 vanop PCB, 11 vanop PCA)
![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht03/labo2/screens/ping%20_PCA.png "Linux-host")
![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht03/labo2/screens/ping_PCB.png "Windows-host")
![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht03/labo2/screens/ip-PCB00.png "Packet tracer")

5. Console-connectie naar switches
  * Zorg ervoor dat de console-kabel verbonden is tussen de COM-poort van de computer en de Console poort van de switch
  * In windows is Tera Term nodig om de connectie tot stand te brengen.
  * In Linux, open een terminal en voer uit `#screen /dev/ttyS0`
 

--NOOT-- Vanaf hier voeren we alles uit in Packet tracer omdat in de klas zowel de serie 2940 als de serie 2960 switches slechts gedeeltelijke uitvoer gaven.  
![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht03/labo2/screens/uitvoer.png "gedeeltelijke uitvoer")

6. Basic switch instellingen
 * Om naar de geprivilegeerde EXEC mode te gaan, gebruik `enable`
 * Om naar de configuratie mode te gaan, gebruik `configure terminal`
 * Om de hostnaam aan te passen, gebruik `hostname S1`
 * Om dns lookups bij foute commando's uit te schakelen, gebruik `no ip domain-lookup`
 * pas de paswoorden aan:
  * `enable secret class`
  * `line con 0`
  * `password cisco`
  * `login`
  * `exit`
 * Om een MOTD in te stellen, doe:
  * `banner motd #`
  * `Unauthorized access is strictly prohibited and prosecuted to the full extent of the law. #`
  * `exit`
 * Om de running-config naar de startup-config te schrijven, doe `copy running-config startup-config`
 * Druk op enter om te bevestigen  
![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht03/labo2/screens/ip-S1.png "In- en uitvoer tot hier")  
![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht03/labo2/screens/ip-S1-01.png "In- en uitvoer tot hier")
 * Om de config te controleren, doe `show running-config`  
![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht03/labo2/screens/ip-s1-02.png "Uitvoer conf")  
![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht03/labo2/screens/ip-s1-03.png "Uitvoer conf")  
![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht03/labo2/screens/ip-s1-04.png "Uitvoer conf")

7. Status van de interfaces tonen
 * Voer het commando uit: `show ip interface brief`
![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht03/labo2/screens/ip-S1-showinterface00.png "Uitvoer if")  
![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht03/labo2/screens/ip-S1-showinterface01.png "Uitvoer if")  
![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht03/labo2/screens/ip-S1-showinterface02.png "Uitvoer if")

8. Doe alle stappen van de switch, ook op Switch2
9. Klaar.
