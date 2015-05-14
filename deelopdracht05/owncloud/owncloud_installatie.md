##Basisinstallatie Owncloud met een **lokale VM** in testnetwerk

Doelstelling: de basisstappen voor installatie en configuratie van een Owncloud-server + AD-integratie doorlopen met een **lokale** VM. We vertrekken van een gekende netwerkconfiguratie (intern netwerk met VirtualBox-VM's, dit om eventuele verbindingsproblemen beter te kunnen lokaliseren. 

Startpunt: 

* DC met AD, DHCP en DNS in toestand na uitvoeren van de eerste 5 hoofdstukken van het handboek Windows Server.
* VirtualBox-netwerkinstelling voor deze DC:
   * 1 netwerkkaart ingesteld op NAT (voor verbinding met het internet)
   * 1 netwerkkaart ingesteld op Internal Network (voor privaat, lokaal netwerk)
* Bitnami owncloud image (Ubuntu) gedownload van: https://bitnami.com/redirect/to/51478/bitnami-owncloud-8.0.2-0-ubuntu-14.04.zip

###Bitnami owncloud VM aanmaken

1. Download VM en pak uit. Je moet VirtualBox later doorverwijzen naar de locatie waar je de bestanden neerzet. 
2. VM toevoegen aan VirtualBox: https://wiki.bitnami.com/Virtual_Appliances_Quick_Start_Guide#How_to_start_your_Bitnami_Virtual_Appliance.3f
3. Kijk na of de **netwerkkaart in VirtualBox** correct is ingesteld: netwerkkaart ingesteld op **Internal Network**

###Reservering DHCP in Windows Server
Voor een lokale server (dus binnen het private bedrijfsnetwerk) een DHCP-reservering toevoegen in de DHCP-server

MMC DHCP > Scope > rechtsklik Reservations > New Reservation...
Het MAC-adres van de netwerkkaart van de server kan je in het onderdeel Network>Advanced van de VirtualBox-settings voor de machine vinden

_Gereserveerd IP: 192.168.101.80_

Dit IP toepassen op de bitnami server. Standaard staat DHCP aan voor deze machine.  
Als je de reservering hebt toegevoegd vóór je de machine voor de eerste keer hebt opgestart: niets doen.
Als de machine al is opgestart voordat je de reservering hebt toegevoegd (en dus via DHCP een dynamisch IP heeft ontvangen):

1. commando `ip a` geeft je een overzicht van configuratie netwerkinterfaces: normaal heeft de netwerkkaart de naam `eth0`
2. `sudo dhclient -r eth0` geeft het toegewezen IP expliciet vrij
3. `sudo dhclient eth0` vraagt een nieuw IP-adres, de server krijgt nu dus het gereserveerde adres toegewezen
4. controleer nog eens met `ip a` of de server nu het IP 192.168.101.80 heeft

###Gebruikers en groepen voor owncloud in AD

####Een user account voor de owncloudserver, zodat deze AD kan lezen.

Doelstelling: we maken OU Service Accounts aan met daarin de 'gebruiker' LDAP-lookup. Deze account is niet voor een persoon, maar voor de Owncloud-server, daarom de nieuwe OU Service Accounts. Deze kan later eventueel ook voor andere gelijkaardige accounts gebruikt worden.

OU aangemaakt: Service Accounts
Gebruiker: LDAP-lookup

1. Kies een OU waar je de gebruiker in wil plaatsen (_Service Accounts_)
2. New > User 
3. Vul het venster in: Login name:_ldaplookup_ Full name:_LDAP-lookup_ Password:_KiesPaswoord_ Wegvinken: User must change password at next logon Aanvinken: Password never expires

####Gebruikersgroepen die toegang zullen hebben tot owncloud: één groep in AD

Doelstelling: groepenstructuur voor toegang tot Owncloud en diensten aanbrengen in AD.  
* 1 basisgroep _ocusers_
* groepen in elk van de OU's van de afdelingen
* deze groepen lid maken van de basisgroep (geneste groepen)
* de gebruikers lid maken van 1 van de groepen

Resultaat: groepen en groeplidmaatschap gaan mee Owncloud in, zodat de gebruikers al in de juiste groep zitten in Owncloud.

OU aangemaakt: Testafdelingen (in de root van het domein)

Een owncloudgroep aanmaken in AD  
De leden van deze group (direct en genest) zullen toegang hebben tot owncloud.
* MMC Users and Computers > New > group: _ocusers_ (Security group, Global)

Test van nested groups:

* 3 OU's: Technical, HR, Sales, allemaal binnen de OU Testafdelingen
* binnen elke OU één group voor oc-toegang: oc-technical, oc-hr, oc-sales (allemaal Global en Security groups)
* de 3 groups allemaal lid gemaakt van de group ocusers
* één testgebruiker: in OU Testafdelingen, direct lid van group ocusers
* één testgebruiker: in OU Technical, lid gemaakt van de group oc-technical


Gegevens testgebruikers

* OU Testafdelingen  
   Gebruiker _Testuser-01_, pass _KiesPaswoord_. Deze gebruiker lid maken van de group ocusers
* OU Technical  
   Gebruiker _technical-testuser_, pass _KiesPaswoord_. Deze gebruiker lid maken van de group oc-technical.

###Inloggen op de Bitnami VM
Eerste keer inloggen: l/p bitnami/bitnami  
De machine vraagt je om het paswoord te wijzigen, doe dit. (user is nog steeds bitnami)

###Owncloud configureren
Start de VM op. Surf van op DC naar het IP-adres van de server (_192.168.101.80_)
  Als Enhanced Security in IE aanstaat, krijg je een waarschuwing. Klik op Add.. om de server aan de vertrouwde sites toe te voegen. Klik nog eens op Add. **Herlaad de loginpagina**.

####Admingebruiker  
Standaard l/p: user/bitnami  
Wijzigen: klik bovenaan in het adminvenster op je username (_user_) > Personal

Let op: de username komt op meerdere plaatsen in de database voor en kan je niet eenvoudig wijzigen. Je Full Name in de Personal-tab wijzigen verandert dus niet je loginnaam!

####LDAP-backend

De LDAP-backend is de component die verbinding zal leggen met de DC om daar gebruikers en groepen op te halen. De backend slaat zelf geen paswoorden op, maar geeft de gebruikersgegevens bij login door aan DC.

#####LDAP backend aanzetten  
Klik bovenaan links op Apps > + Apps
Klik op Not enabled > Scroll naar `LDAP user and group backend` > Enable

#####LDAP backend configureren  
Open MMC AD Users and Computers > menu `View` > check optie `Advanced Features`. Properties van een object openen geeft nu extra tabbladen, waaronder de Attribute Editor. Die kunnen we later gebruiken om gegevens uit te kopiëren en zo de kans op fouten te verminderen.

######Tabblad Server

* **hostnaam**: servernaam.domein.topleveldomein (_PFSV1.PoliForma.nl_)
* **user DN**: open in MMC U&C de Properties van de gebruiker die je hebt aangemaakt voor de LDAP-lookup > tabblad `Attribute Editor` > selecteer attribuut `distinguishedName` > klik onder de lijst op `View` > kopieer de waarde en plak ze in het vak user DN
* **wachtwoord**: het wachtwoord van de LDAP-lookup user
* **Base DN** (DC=domein,DC=topleveldomein) en port (**389** voor LDAP) worden normaal automatisch gedetecteerd

######Tabblad Expert

Internal Username: vul hier `sAMAccountName` in (dit zorgt ervoor dat de usernames binnenin owncloud dezelfde zijn als in AD) > Save

######Tabblad Advanced

* Configuration Active: check
* Case-insensitive LDAP-server: check
* Turn off SSL certificate validation: check **alleen voor testdoeleinden, niet in productie**
* Cache TTL: 5 **alleen voor testdoeleinden**, 600 is OK voor productie

######Tabblad User Filter

* klik op `Edit raw filter instead`
* waarde: `memberOf:1.2.840.113556.1.4.1941:=cn=_ocusers_,ou=_Testafdelingen_,dc=_PoliForma_,dc=_nl_`  
   * memberOf:1.2.840.113556.1.4.1941: deze filter retourneert alle objecten die lid zijn van ocusers, inclusief indirecte leden door nesting (dus ook de leden van de subgroepen)
   * cn=_groupname_: de canonical name van de group 
   * ou=_groupou_: de ou waar groep ocusers in geplaatst is 

######Tabblad Login Filter

* laat `LDAP Username` aangevinkt staan

######Tabblad Group Filter

* only from those groups: _ocusers,oc-technical,oc-hr,oc-sales_ (aanvinken in de lijst)


Als alles goed is, krijg je nu groen licht (Configuration OK). Gebruikersmenu rechterbovenhoek > Users geeft een overzicht van alle oc-gebruikers gevonden in AD, met hun groeplidmaatschap.

##Owncloud met Azure VM

###Bitnami Azure Launchpad

Nodig:
* een Microsoft Azure account
* een Bitnami account: je kan hiervoor ook je Github-account gebruiken

We moeten Bitnami eerst (eenmalig) toestemming geven om applicaties en VM's op te zetten in Microsoft Azure. Hiervoor moeten we een Management Certificate aanmaken en invoeren in de Bitnami-account.
Daarna kunnen we de VM laten opzetten.

1. Surf naar https://azure.bitnami.com/
2. Klik in de lijst van toepassingen op Owncloud > Launch in account
3. Log in op Bitnami (eventueel via Github)
4. Volg de stappen op het scherm: Klik op `Create a management certificate for Microsoft Azure`  
   Je wordt doorverwezen en moet inloggen op Azure om een .publishsettings-bestand te downloaden. Je moet ook een nieuw paswoord kiezen voor je Bitnami vault (waar certificaten e.d. voor de integratie Bitnami-Azure zitten opgeslagen, je kan er later ook een overzicht krijgen van je aangemaakte VM's).
   ![alt] (/deelopdracht05/owncloud/owncloud_files/bitnazure_stap1.png "managementcert azure")
5. Configureer de aan te maken VM:
   * Kies als regio **West Europe** (dit komt neer op een locatie in Nederland)
   * Voor een test-/demo-omgeving kan je kiezen voor server size **A0** (traag maar goedkoop)
6. Klik op `Create Virtual Machine` (of `Create`).  
   Bitnami maakt nu VM en Storage account aan. Dit kan even duren. Bovenaan de pagina zie je de voortgang.
   
Noot: aanmaken en basisbeheer (opstarten, afsluiten, wissen) van je Bitnami VM's kan je vanaf nu via de Bitnami Vault doen. Inloggen op Bitnami via https://azure.bitnami.com/ en je Vault-paswoord ingeven.
Je kan nu ook Bitnami images uitkiezen in Azure Management Portal > sectie 'Virtual Machines' > tab 'Images' > menu onderaan 'Browse VM Depot'

Referenties:
* https://wiki.bitnami.com/Azure_Cloud/Getting_Started 

 
###VPN lokaal netwerk - Azure

####Azure: Virtueel netwerk aanmaken en bereikbaar maken

Azure Management Portal > kolom links `Networks` > 
* `Create a new virtual network` (alleen zichtbaar als je nog geen Virtual Networks hebt gedefinieerd)
* of onderaan `+ New` > `Custom Create`

#####Stap 1: Naam en locatie

* **Name**: kies een naam (_AzureDevNetwerk_)
* **Location**: kies **West Europe**. De locatie bepaalt waar VM's die deel uitmaken van het netwerk worden gehuisvest.  
Let op! Alleen VM's die aangemaakt zijn met **dezelfde regio** als het virtueel netwerk kunnen aan het netwerk toegevoegd worden!

![Vnet stap 1] ( /deelopdracht05/owncloud/owncloud_files/vnet_stap1.png "naam en locatie vnet" )  

#####Stap 2: DNS en soort VPN

* **DNS-sectie** blanco: Microsoft DNS-service wordt gebruikt. Dit betekent: geen name resolution van het interne netwerk naar het virtuele netwerk (dus ip-adressen gebruiken).  
* **Connectivity**: point-to-site aanvinken

Betekenis point-to-site VPN: verbindt specifieke client(s) van het interne netwerk via VPN met het Azure-vnet.
* er moet een rootcertificaat toegevoegd worden aan het vnet (zie onder)
* elke client moet een apart clientcertificaat krijgen, aangemaakt o.b.v. het rootcertificaat (zie onder)

Waarom point-to-site en niet site-to-site? Site-to-site verbindt een volledig lokaal netwerk met het Azure-vnet. Clients hebben dus niet allemaal een apart certificaat nodig. Maar: je hebt een VPN-machine of Windows Server geconfigureerd voor RRAS (Routing and Remote Access Service) nodig die een publiek IPv4-adres heeft en niet achter NAT zit. Dit hebben we niet en hebben we ook niet nodig. Alleen de DC moet immers via VPN communiceren met de LDAP-backend op de Owncloud-server. Alle andere clients (gebruikers) hebben alleen de (webgeserveerde) front-end nodig.

![Vnet stap 2] ( /deelopdracht05/owncloud/owncloud_files/vnet_stap2.png "dns en point-to-site" )  

#####Stap 3: Point-to-Site Connectivity configureren

**Adresruimte** voor het virtuele netwerk aangeven.  
Deze mag niet overlappen met het interne netwerk. De VPN-clients krijgen een adres uit deze range toegewezen, verkeer van op de client naar een adres uit dit bereik wordt omgeleid naar de VPN. Dus: als de range overlapt zijn lokale clients mogelijk niet meer bereikbaar.  
Je kan het netwerkadres aanpassen in de kolom 'Starting IP'.  
![Vnet stap 3] ( /deelopdracht05/owncloud/owncloud_files/vnet_stap3.png "adresbereik" )

#####Stap 4: Overzicht adresruimte en subnet voor gateway aanmaken

10.0.0.0 in stap 3 levert in stap 4 het bereik 10.0.1.0/24. Klik op `Add gateway subnet`. Het voorgestelde subnet is OK.

![Vnet stap 4] ( /deelopdracht05/owncloud/owncloud_files/vnet_stap4.png "address spaces" )

Resultaat (tab Networks)

![vnet aangemaakt] ( /deelopdracht05/owncloud/owncloud_files/created_vnet.png "vnet aangemaakt")

#####Stap 5: Gateway aanmaken

Klik op de naam van het netwerk > Dashboard om naar zijn Dashboard te gaan. Je ziet een foutmelding (The gateway was not created). Klik onderaan op `Create gateway`. Het aanmaken kan enkele minuten duren.

![create gateway] ( /deelopdracht05/owncloud/owncloud_files/vnet_stap5.png "create gateway" )

Let op! Als het wel héél lang lijkt te duren, lijkt alsof het aanmaken is vastgelopen: waarschijnlijk is de pagina gecached in je browser. Log eens uit, herstart de browser en log opnieuw in.

Resultaat: de gateway is aangemaakt, hij heeft een IP-adres.

![created gateway] ( /deelopdracht05/owncloud/owncloud_files/created_gateway.png "gateway aangemaakt")


####Certificaten aanmaken en toevoegen

Doelstellingen:
* een self-signed root-certificaat aanmaken en importeren in het managementportaal. Alleen self-signed certificates worden ondersteund!
* voor elke client (hier: alleen DC) een clientcertificaat aanmaken o.b.v. dit rootcertificaat. Het clientcertificaat toevoegen aan de certificate store op de client.
* het juiste Client VPN Package downloaden en uitvoeren op elke client (hier: alleen DC)

Je hebt nodig:
* de tool makecert.exe. Deze maakt deel uit van het pakket Visual Studio Tools, onderdeel van Visual Studio 2013 (gebruikt: de Ultimate-versie, de tools zitten ook in de gratis versie Express 2013 for Windows Desktop)

#####Stap 1: Rootcertificaat aanmaken

We maken een certificaat + private aan op een lokale computer, in de Certificate Store 'Personal'. We importeren het certificaat, zonder de private sleutel (.cer-bestand) in Azure.

1. Open een command prompt **als administrator** en navigeer naar de plaats waar je het .cer-bestand wil opslaan.
2. Geef het commando `makecert -sky exchange -r -n "CN=VPNAzureRootCertificate" -pe -a sha1 -len 2048 -ss My "VPNAzureRootCertificate.cer"`in, waarbij _VPNAzureRootCertificate_ een naam is die je zelf kiest. Als het lukt, krijg je simpelweg de boodschap `Succeeded`.
3. Ga in Azure Management Portal naar het Dashboard van het Virtual Network (zie 'Virtueel netwerk aanmaken en bereikbaar maken') > tab 'Certificates'
   ![alt] (/deelopdracht05/owncloud/owncloud_files/cert_stap1.png "rootcert uploaden")
4. Kies het .cer-bestand van het root-certificaat en bevestig.

#####Stap 2: Clientcertificaat aanmaken

We maken op dezelfde computer die we gebruikten voor het root-certificaat een client-certificaat aan. 
Dit exporteren we (private key inclusief) naar een .pfx-bestand.
Later importeren we het certificaat via het pfx-bestand op de client die verbinding moet maken met de Owncloud-server (dit is de DC-VM).

1. Open een command prompt **als administrator**.
2. Geef het commando `makecert.exe -n "CN=VPNAzureClient" -pe -sky exchange -m 96 -ss My -in "VPNAzureRootCertificate" -is my -a sha1` in
   * de naam _VPNAzureClient_ is vrij te kiezen
   * de naam achter de switch `-in` is de naam van het root-certificaat (niet het .cer-bestand!) uit Stap 1
3. Als het gelukt is, krijg je weer de boodschap `Succeeded`
4. Run `certmgr.msc` en vouw de store 'Personal' > 'Certificates' uit. Hier zie je zowel het root-certificaat als het client-certificaat dat je hebt aangemaakt.
5. Rechtsklik op het client-certificaat > 'All tasks' > 'Export...' > Next
6. De **private key** moet je mee exporteren.
   ![alt] (/deelopdracht05/owncloud/owncloud_files/cert_stap6.png "private key exporteren")
7. In het scherm 'Export file format' kan je alles laten staan.
   ![alt] (/deelopdracht05/owncloud/owncloud_files/cert_stap7.png "clientcert bestandsformaat")
8. In het volgende scherm moet je een paswoord opgeven voor de private key. Dit paswoord moet je bij het importeren op de VPN-client opnieuw ingeven dus hou het bij.  
   ![alt] (/deelopdracht05/owncloud/owncloud_files/cert_stap8.png "private key paswoord")
9. Geef een bestandsnaam op voor het te exporteren bestand. Kies de locatie via 'Browse...' zodat je het later nog terugvindt. Klik op Finish.

#####Stap 3: Clientcertificaat importeren op de domeincontroller

We importeren het aangemaakte clientcertificaat in de certificate store van DC (guest VM).

Nodig: het pfx-bestand uit Stap 2 op een locatie beschikbaar voor de guest (gedeelde map of usb)

1. Dubbelklik **in de guest VM** op het pfx-bestand > Next > Next  
   ![alt] (/deelopdracht05/owncloud/owncloud_files/certimport_stap1.png "Start importeren" )  
   ![alt] (/deelopdracht05/owncloud/owncloud_files/certimport_stap1b.png "Importeren - kies bestand" )
2. Geef het paswoord in > Next  
   ![alt] (/deelopdracht05/owncloud/owncloud_files/certimport_stap2.png "Importeren - paswoord" )
3. Laat de certificate store automatisch kiezen > Next  
   ![alt] (/deelopdracht05/owncloud/owncloud_files/certimport_stap3.png "Importeren - certificate store")
4. Klik op Finish  
   ![alt] (/deelopdracht05/owncloud/owncloud_files/certimport_stap4.png "Importeren - eindoverzicht" )
   Je krijgt een melding:  
   ![alt] (/deelopdracht05/owncloud/owncloud_files/certimport_success.png "Importeren succesvol" )

#####Stap 4: VPN-verbinding maken

We downloaden het pakket voor de VPN-verbinding met het virtuele netwerk van de Azure Management Portal. We voeren dit uit op DC (guest VM).

1. Log in op de Azure Management Portal > tab Networks > Klik op het virtuele netwerk in de lijst.  
   ![alt] (/deelopdracht05/owncloud/owncloud_files/vpnconnect_stap1.png "vpn-verbinding stap 1" )
2. Ga naar het Dashboard van dit netwerk > Download the 64-bit Client VPN Package.  
   ![alt] (/deelopdracht05/owncloud/owncloud_files/vpnconnect_stap2.png "vpn-verbinding stap 2" )
3. Sla dit bestand (.exe) op op een locatie die beschikbaar is in de guest VM (shared folder of usb).
4. Dubbelklik **in de guest VM** op het bestand. Je krijgt een beveiligingswaarschuwing.  
   ![alt] (/deelopdracht05/owncloud/owncloud_files/vpnconnect_stap4.png "vpn-verbinding stap 4" )
5. Bevestig de installatie van de VPN-client.   
   ![alt] (/deelopdracht05/owncloud/owncloud_files/vpnconnect_stap5.png "vpn-verbinding stap 5" )
6. Open Network Connections (Rechtsklik op de Windowsknop > Network Connections).  
   ![alt] (/deelopdracht05/owncloud/owncloud_files/vpnconnect_stap6.png "vpn-verbinding stap 6" )
7. Dubbelklik op de VPN-verbinding.   
   ![alt] (/deelopdracht05/owncloud/owncloud_files/vpnconnect_stap7.png "vpn-verbinding stap 7" )
8. Klik op de naam van het VPN en Connect.  
   ![alt] (/deelopdracht05/owncloud/owncloud_files/vpnconnect_stap8.png "vpn-verbinding stap 8" )
9. Klik nog eens op Connect.  
   ![alt] (/deelopdracht05/owncloud/owncloud_files/vpnconnect_stap9.png "vpn-verbinding stap 9" )
10. Geef toestemming om door te gaan.  
   ![alt] (/deelopdracht05/owncloud/owncloud_files/vpnconnect_stap10.png "vpn-verbinding stap 10" )
   In Network Connections kan je zien of de verbinding actief is:
   ![alt] (/deelopdracht05/owncloud/owncloud_files/vpnconnect_success.png "vpn-verbinding succes" )

Referenties:  
* https://msdn.microsoft.com/en-us/library/azure/dn133792.aspx
* https://msdn.microsoft.com/en-us/library/azure/09926218-92ab-4f43-aa99-83ab4d355555#BKMK_VNETDNS






