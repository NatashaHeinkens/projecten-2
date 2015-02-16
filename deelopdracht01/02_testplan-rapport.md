## Testplan en -rapport taak 2: IP Planning 

* Verantwoordelijke uitvoering: NAAM
* Verantwoordelijke testen: NAAM

### Testplan

Auteur testplan: Birgitta Croux

Testen op te zetten in Packet Tracer

1. Netwerktopologie opzetten cf. ip-planning en gegeven fysieke topologie
2. Configuratie van hosts
  1. Basisconfiguratie, niet strikt noodzakelijk voor de test: hostname instellen op de 3 routers
  2. IP-configuratie  
     Voor elke gebruikte interface op de routers ip-adres en subnetmask instellen. Voor het ip-adres kiezen we het eerste beschikbare host-adres.  
     Voor elk end device ip, subnet mask en default gateway instellen. Voor het ip-adres kiezen we het laatste beschikbare host-adres.
  3. Configuratie van de nodige static routes voor elke router  
     Voor de subnetten die niet rechtstreeks met een interface op de router verbonden zijn moet er routeringsinformatie toegevoegd worden. Static routes zijn een geschikte manier om dit te doen in het kader van deze test.
3. Connectiviteit testen  
   Ping vanop end devices naar default gateway, naar end device in ander subnet op dezelfde router (indien van toepassing), naar end device in ander subnet op andere router, naar Verbinding met ISP.

### Testrapport

Uitvoerder test: Birgitta Croux

1. Netwerktopologie opzetten: zie test_ipplanning.pkt
2. Configuratie  
   Bedrijfsrouter 1
   ```
   enable
   conf t
   hostname Bedrijfsrouter1
   
   interface Serial 0/0/0
   ip address 172.16.0.6 255.255.255.252
   exit
   interface Gig 0/0
   ip address 172.16.0.17 255.255.255.240
   no shutdown
   exit
   interface Gig 0/1
   ip address 172.16.0.33 255.255.255.224
   no shutdown
   exit
   
   ip route 172.16.2.0 255.255.254.0 172.16.05
   ip route 172.16.0.0 255.255.255.252 172.16.05
   exit
   
   copy run sta
   ```
   
   Bedrijfsrouter 2 
   ```
   enable
   conf t
   hostname Bedrijfsrouter2
   
   interface Serial 0/0/1
   ip address 172.16.0.5 255.255.255.252
   exit
   interface Serial 0/0/0
   ip address 172.16.0.2 255.255.255.252
   exit
   interface Gig 0/0
   ip address 172.16.2.1 255.255.254.0
   no shutdown
   exit
   
   ip route 172.16.0.16 255.255.255.240 172.16.0.6
   ip route 172.16.0.32 255.255.255.224 172.16.0.6
   exit
   
   copy run sta
   ```
   
   Verbinding met ISP
   ```
   enable
   conf t
   hostname ToISP
   
   interface Serial 0/0/1
   ip address 172.16.0.1 255.255.255.252
   exit
   
   ip route 172.16.0.4 255.255.255.252 172.16.0.2
   ip route 172.16.2.0 255.255.254.0 172.16.0.2
   ip route 172.16.0.32 255.255.255.224 172.16.0.2
   ip route 172.16.0.16 255.255.255.240 172.16.0.2
   exit
   
   copy run sta
   ```
   
   //TODO: config hosts aanvullen
   
3. Connectiviteit testen  
  //TODO: aanvullen
