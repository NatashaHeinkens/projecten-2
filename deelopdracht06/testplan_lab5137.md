##Deel 1: Fysiek netwerk en basisinstellingen

#######1. Het netwerk heeft de juiste fysieke topologie  
  ![alt] (/deelopdracht06/lab5137_files/fysieke_topologie.png "Fysieke topologie")
  
#######2. PC-A heeft de juiste IP-configuratie:
   1. IP-adres: `192.168.10.3`
   2. Subnet mask: `255.255.255.0`
   3. Default gateway: `192.168.10.1`

#######3. PC-B heeft de juiste IP-configuratie:
   1. IP-adres: `192.168.20.3`
   2. Subnet mask: `255.255.255.0`
   3. Default gateway: `192.168.20.1`

#######4. Intermediaire devices staan aan en hun configuratie is gewist:
   1. Router R1
   2. Switch S1
   3. Switch S2

#######5. Basisinstellingen switch 1 zijn correct:
   1. DNS lookup (ip domain lookup) staat uit
   2. Hostname: `S1`
   3. Paswoord privileged EXEC: class
   4. Paswoord consolelijn: cisco
   5. Paswoord vty-lijn: cisco
   6. Configuratie consolelijn: `logging synchronous`
   7. IP-adres VLAN1: `192.168.1.11`,subnet mask `255.255.255.0`
   8. Default gateway VLAN1: `192.168.1.1`
   9. Alle ongebruikte poorten zijn `Administratively down`
   10. Running configuration is gekopieerd naar startup configuration

#######6. Basisinstellingen switch 2 zijn correct:
   1. DNS lookup (ip domain lookup) staat uit
   2. Hostname: `S2`
   3. Paswoord privileged EXEC: class
   4. Paswoord consolelijn: cisco
   5. Paswoord vty-lijn: cisco
   6. Configuratie consolelijn: `logging synchronous`
   7. IP-adres VLAN1: `192.168.1.12`, subnet mask `255.255.255.0`
   8. Default gateway VLAN1: `192.168.1.1`
   9. Alle ongebruikte poorten zijn `Administratively down`
   10. Running configuration is gekopieerd naar startup configuration

#######7. Basisinstellingen router zijn correct:
   1. DNS lookup (ip domain lookup) staat uit
   2. Hostname: `R1`
   3. Paswoord privileged EXEC: class
   4. Paswoord consolelijn: cisco
   5. Paswoord vty-lijn: cisco
   6. Configuratie consolelijn: `logging synchronous`
   7. IP-adres interface Lo0: `209.165.200.225`, subnet mask `255.255.255.224`
   8. Running configuration is gekopieerd naar startup configuration


##Deel 2: Configuratie switches voor VLAN en trunklink

#######1. Configuratie VLAN op switch 1 is correct:
1. eerste VLAN is aangemaakt: 
   * vlan_id: `10`
   * naam: `Students`
2. tweede VLAN is aangemaakt:
   * vlan_id: 20
   * naam: `Faculty`
3. De interface verbonden met S2 (interface **f0/1**, zie fysieke topologie) is geconfigureerd (switchport mode) als VLAN-trunk
4. De interface verbonden met R1 (interface **f0/5**, zie fysieke topologie) is geconfigureerd (switchport mode) als VLAN-trunk
5. De interface verbonden met PC-A (interface **f0/6**, zie fysieke topologie) is toegekend aan VLAN 10
   * switchport mode is permanent ingesteld op `access`
   * het access vlan voor deze interface is `10` (dit is het vlan_id)

#######2. Configuratie VLAN op switch 2 is correct:
1. eerste VLAN is aangemaakt: 
   * vlan_id: `10`
   * naam: `Students`
2. tweede VLAN is aangemaakt:
   * vlan_id: 20
   * naam: `Faculty`
3. De namen en id's voor de vlan's zijn dezelfde op S1 en S2
4. De interface verbonden met S1 (interface **f0/1**, zie fysieke topologie) is geconfigureerd (switchport mode) als VLAN-trunk
5. De interface verbonden met PC-B (interface **f0/18**, zie fysieke topologie) is toegekend aan VLAN 20
   * switchport mode is permanent ingesteld op `access`
   * het access vlan voor deze interface is `20` (dit is het vlan_id)


##Deel 3: Configuratie router voor router-on-a-stick inter-VLAN routing

#######1. Configuratie subinterface voor VLAN 1 op de router is correct:
1. Vlan 1 is aangemaakt op R1, interface g0/1
2. Subinterface 1 op interface g0/1 is geconfigureerd om op vlan 1 te werken (via `encapsulation dot1q`)
3. IP-adres van subinterface 1: `192.168.1.1`, subnet mask `255.255.255.0`

#######2. Configuratie subinterface voor VLAN 10 op de router is correct:
1. Vlan 10 is aangemaakt op R1, interface g0/1
2. Subinterface 10 op interface g0/1 is geconfigureerd om op vlan 10 te werken (via `encapsulation dot1q`)
2. IP-adres van subinterface 10: `192.168.10.1`, subnet mask `255.255.255.0`

#######3. Configuratie subinterface voor VLAN 20 op de router is correct:
1. Vlan 20 is aangemaakt op R1, interface g0/1
2. Subinterface 20 op interface g0/1 is geconfigureerd om op vlan 20 te werken (via `encapsulation dot1q`)
3. IP-adres van subinterface 20: `192.168.20.1`, subnet mask `255.255.255.0`

#######4. De interface op de router staat aan
1. De status van interface g0/1 is `up`

#######5. Connectiviteit is nagegaan:
1. De routeringstabel op R1 toont //TODO
2. Ping van PC-A (vlan 10) naar default gateway (`192.168.10.1`) is succesvol
3. Ping van PC-A naar PC-B (`192.168.20.3`) is succesvol
4. Ping van PC-A naar Lo0 (`209.165.200.225`) is succesvol
5. Ping van PC-A naar S2 (`192.168.1.12`) is succesvol
