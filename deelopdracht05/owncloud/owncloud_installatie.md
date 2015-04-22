##Basisinstallatie Owncloud met een **lokale VM** in testnetwerk

Startpunt: 

*DC met AD, DHCP en DNS in toestand na uitvoeren van de eerste 5 hoofdstukken van het handboek Windows Server.
*Bitnami owncloud image (Ubuntu) gedownload van: https://bitnami.com/redirect/to/51478/bitnami-owncloud-8.0.2-0-ubuntu-14.04.zip

###Bitnami owncloud VM aanmaken
Download VM en pak uit. Je moet VirtualBox later doorverwijzen naar de locatie waar je de bestanden neerzet. 
VM toevoegen aan VirtualBox: https://wiki.bitnami.com/Virtual_Appliances_Quick_Start_Guide#How_to_start_your_Bitnami_Virtual_Appliance.3f
Kijk na of de **netwerkkaart in VirtualBox** correct is ingesteld: netwerkkaart ingesteld op **Internal Network**

###Reservering DHCP in Windows Server
Voor een lokale server (dus binnen het private bedrijfsnetwerk) een DHCP-reservering toevoegen in de DHCP-server

MMC DHCP > Scope > rechtsklik Reservations > New Reservation...
Het MAC-adres van de netwerkkaart van de server kan je in het onderdeel Network>Advanced van de VirtualBox-settings voor de machine vinden

_Gereserveerd IP: 192.168.101.80_

Dit IP toepassen op de bitnami server (standaard staat DHCP aan voor deze machine)
Als je de reservering hebt toegevoegd voor je de machine voor de eerste keer hebt opgestart: niets doen.
Als de machine al is opgestart voordat je de reservering hebt toegevoegd (en dus via DHCP een IP heeft ontvangen):
1. commando `ip a` geeft je een overzicht van configuratie netwerkinterfaces: normaal heeft de netwerkkaart de naam `eth0`
2. `sudo dhclient -r eth0` geeft het toegewezen IP expliciet vrij
3. `sudo dhclient eth0` vraagt een nieuw IP-adres, de server krijgt nu dus het gereserveerde adres toegewezen
4. controleer nog eens met `ip a` of de server nu het IP 192.168.101.80 heeft

###Gebruikers en groepen voor owncloud in AD

####Een user account voor de owncloudserver, zodat deze AD kan lezen.

OU aangemaakt: Service Accounts
Gebruiker: LDAP-lookup

1. Kies een OU waar je de gebruiker in wil plaatsen (_Service Accounts_)
2. New > User 
3. Vul het venster in: Login name:_ldaplookup_ Full name:_LDAP-lookup_ Password:_KiesPaswoord_ Wegvinken: User must change password at next logon Aanvinken: Password never expires

####Gebruikersgroepen die toegang zullen hebben tot owncloud: één groep in AD

OU aangemaakt: Testafdelingen (in de root van het domein)

Een owncloudgroep aanmaken in AD
De leden van deze group (direct en genest) zullen toegang hebben tot owncloud
MMC Users and Computers > New > group: _ocusers_ (Security group, Global)

Test van nested groups:

* 3 OU's: Technical, HR, Sales, allemaal binnen de OU Testafdelingen
* binnen elke OU één group voor oc-toegang: oc-technical, oc-hr, oc-sales (allemaal Global en Security groups)
* de 3 groups allemaal lid gemaakt van de group ocusers
* één testgebruiker: in OU Testafdelingen, direct lid van group ocusers
* één testgebruiker: in OU Technical, lid gemaakt van de group oc-technical


Gegevens testgebruikers

* OU Testafdelingen  
   Gebruiker _Testuser-01_, pass _KiesPaswoord_. Deze gebruiker lid maken van de group ocusers!
* OU Technical  
   Gebruiker _technical-testuser_, pass _KiesPaswoord_. Deze gebruiker lid maken van de group oc-technical.

###Inloggen op de Bitnami VM
Eerste keer inloggen: l/p bitnami/bitnami
De machine vraagt je om het paswoord te wijzigen, doe dit. (user is nog steeds bitnami)

###Owncloud configureren
Start de VM op. Surf van op DC naar het IP-adres van de server (_192.168.101.30_)
  Als Enhanced Security in IE aanstaat, krijg je een waarschuwing. Klik op Add.. om de server aan de vertrouwde sites toe te voegen. Klik nog eens op Add. Herlaad de loginpagina.

####Admingebruiker  
Standaard l/p: user/bitnami
Wijzigen: klik bovenaan in het adminvenster op je username (_user_) > Personal


Let op: de username komt op meerdere plaatsen in de database voor en kan je niet eenvoudig wijzigen. Je Full Name in de Personal-tab wijzigen verandert dus niet je loginnaam!

LDAP backend aanzetten
Klik bovenaan links op Apps > + Apps
Klik op Not enabled > Scroll naar `LDAP user and group backend` > Enable

LDAP backend configureren
Open MMC AD Users and Computers > menu `View` > check optie `Advanced Features`. Properties van een object openen geeft nu extra tabbladen, waaronder de Attribute Editor.

Tabblad Server

* hostnaam: servernaam.domein.topleveldomein
* user DN: open in MMC U&C de Properties van de gebruiker die je hebt aangemaakt voor de LDAP-lookup > tabblad `Attribute Editor` > selecteer attribuut `distinguishedName` > klik onder de lijst op View > kopieer de waarde en plak ze in het vak user DN
* wachtwoord: het wachtwoord dat van de LDAP-lookup user
* Base DN (DC=domein,DC=topleveldomein) en port (389 voor LDAP) worden normaal automatisch gedetecteerd

Tabblad Expert

Internal Username: vul hier `sAMAccountName` in (dit zorgt ervoor dat de usernames binnenin owncloud dezelfde zijn als in AD) > Save

Tabblad Advanced

* Configuration Active: check
* Case-insensitive LDAP-server: check
* Turn off SSL certificate validation: check **alleen voor testdoeleinden, niet in productie**
* Cache TTL: 5 **alleen voor testdoeleinden**, 600 is OK voor productie

Tabblad User Filter

* klik op `Edit raw filter instead`
* waarde: `memberOf:1.2.840.113556.1.4.1941:=cn=_ocusers_,ou=_Testafdelingen_,dc=_PoliForma_,dc=_nl_`  
   * memberOf:1.2.840.113556.1.4.1941: deze filter retourneert alle objecten die lid zijn van ocusers, inclusief indirecte leden door nesting
   * cn=_groupname_: de canonical name van de group 
   * ou=_groupou_: de ou waar groep ocusers in geplaatst is 

Tabblad Login Filter

* laat `LDAP Username` aangevinkt staan

Tabblad Group Filter

* only from those groups: _ocusers,oc-technical,oc-hr,oc-sales_ (aanvinken in de lijst)


Als alles goed is, krijg je nu groen licht (Configuration OK). Gebruikersmenu rechterbovenhoek > Users geeft een overzicht van alle oc-gebruikers gevonden in AD.

##Owncloud met Azure VM


###Bitnami Azure Launchpad

//TODO 
 
###Interne VM bereikbaar maken vanaf het internet

//TODO

Om ons interne netwerk van VM's internettoegang te geven, hebben we één netwerkinterface van onze DC als NAT-interface ingesteld. Die interface krijgt een IP toebedeeld van de interne DHCP-server van VirtualBox, tenzij dit anders is ingesteld.
Om onze DC bereikbaar te maken van buitenaf (vanaf de host of vanaf het internet) voor de LDAP-lookup zetten we port forwarding op.




