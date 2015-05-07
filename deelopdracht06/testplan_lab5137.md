##Deel 1: Fysiek netwerk en basisinstellingen

1. Het netwerk heeft de juiste fysieke topologie  
  ![alt] (/deelopdracht06/lab5137_files/fysieke_topologie.png "Fysieke topologie")
2. PC-A heeft de juiste IP-configuratie:
   1. IP-adres: `192.168.10.3`
   2. Subnet mask: `255.255.255.0`
   3. Default gateway: `192.168.10.1`
3. PC-B heeft de juiste IP-configuratie:
   1. IP-adres: `192.168.20.3`
   2. Subnet mask: `255.255.255.0`
   3. Default gateway: `192.168.20.1`
4. Intermediaire devices staan aan en hun configuratie is gewist:
   1. Router R1
   2. Switch S1
   3. Switch S2
5. Basisinstellingen switch 1 zijn correct:
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
6. Basisinstellingen switch 2 zijn correct:
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
7. Basisinstellingen router zijn correct:
   1. DNS lookup (ip domain lookup) staat uit
   2. Hostname: `R1`
   3. Paswoord privileged EXEC: class
   4. Paswoord consolelijn: cisco
   5. Paswoord vty-lijn: cisco
   6. Configuratie consolelijn: `logging synchronous`
   7. IP-adres interface Lo0: `209.165.200.225`, subnet mask `255.255.255.224`
   8. Running configuration is gekopieerd naar startup configuration
