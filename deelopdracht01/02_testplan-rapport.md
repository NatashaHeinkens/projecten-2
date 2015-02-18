## Testplan en -rapport taak 2: IP Planning 

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
   Ping vanop end devices naar default gateway, naar end device in ander subnet op dezelfde router (indien van toepassing), naar end device in ander subnet op andere router.

### Testrapport

Uitvoerder test: Birgitta Croux

1. Netwerktopologie opzetten: zie test_ipplanning.pkt
   ![alt text] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht01/testrapport_netwerktopologie.png "netwerktopologie")
2. Configuratie  
   Bedrijfsrouter 1
   ```
   !
   hostname Bedrijfsrouter1
   !
   interface GigabitEthernet0/0
   ip address 172.16.0.17 255.255.255.240
   duplex auto
   speed auto
   !
   interface GigabitEthernet0/1
   ip address 172.16.0.33 255.255.255.224
   duplex auto
   speed auto
   !
   interface Serial0/0/0
   ip address 172.16.0.6 255.255.255.252
   clock rate 2000000
   !
   ip route 172.16.2.0 255.255.254.0 172.16.0.5 
   ip route 172.16.0.0 255.255.255.252 172.16.0.5 
   ip route 0.0.0.0 0.0.0.0 172.16.0.1 
   !
   ```
   
   Bedrijfsrouter 2 
   ```
   !
   hostname Bedrijfsrouter2
   !
   interface GigabitEthernet0/0
   ip address 172.16.2.1 255.255.254.0
   duplex auto
   speed auto
   !
   interface Serial0/0/0
   ip address 172.16.0.2 255.255.255.252
   clock rate 2000000
   !
   interface Serial0/0/1
   ip address 172.16.0.5 255.255.255.252
   !
   ip route 172.16.0.16 255.255.255.240 172.16.0.6 
   ip route 172.16.0.32 255.255.255.224 172.16.0.6 
   ip route 0.0.0.0 0.0.0.0 172.16.0.1 
   !
   ```
   
   Verbinding met ISP
   ```
   !
   hostname ToISP
   !
   interface Serial0/0/1
   ip address 172.16.0.1 255.255.255.252
   !
   ip route 172.16.0.4 255.255.255.252 172.16.0.2 
   ip route 172.16.2.0 255.255.254.0 172.16.0.2 
   ip route 172.16.0.32 255.255.255.224 172.16.0.2 
   ip route 172.16.0.16 255.255.255.240 172.16.0.2 
   !
   ```
   
   Configuratie end devices
   
   | Host           | IP          | Subnet Mask     | Default Gateway |
   | ----           | :--:        | :--:            | :--:            |
   | Directie1      | 172.16.0.30 | 255.255.255.240 | 172.16.0.17     |
   | Administratie1 | 172.16.0.62 | 255.255.255.224 | 172.16.0.33     |
   | Personeel1     | 172.16.3.254| 255.255.254.0   | 172.16.2.1      |
   
3. Connectiviteit testen  
  * Ping naar default gateway: zie scenario's 1-3 test_ipplanning.pkt
  * Ping naar host binnen ander subnet op dezelfde router: zie scenario 4 test_ipplanning.pkt
  * Ping naar host binnen ander subnet op andere router: zie scenario 5 test_ipplanning.pkt
