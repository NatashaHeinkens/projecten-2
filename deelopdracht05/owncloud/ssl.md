##LDAPS (verbinding met LDAP via SSL)

###1. Een Certificate Authority aanmaken

Onder linux is dit doorgaans eenvoudiger omdat openssl vaak al aanwezig is. Bovendien is het geen best practice om van een DC een CA te maken.
Openssl binaries voor Windows: http://indy.fulgan.com/SSL/

referentie: http://www.phildev.net/ssl/creating_ca.html

//TODO: gebruikte inhoud van openssl.cnf kopiëren

###2. De CA erkennen in Windows Server

1. Maak het certificaat van de CA (voorbeeld: _cacert.pem_) ergens beschikbaar in de server.
2. Cmd+r (Run) > mmc > Add/Remove snap-in > Certificates > Add > OK
3. rechtklik Trusted Root Certification Authorities > All Tasks > Import... > Next > navigeer naar de locatie van _cacert.pem_ (Alle bestandsextensies laten tonen) > Next
4. `Place all certificates in the following store: Trusted Root Certification Authorities` > Next > Finish

Optioneel: het console met de certificates-snap-in opslaan (.msc) -> volgende keer openen via File > Open

###3. Certificate signing request genereren (Windows Server)

```
;----------------- request.inf -----------------

[Version]

Signature="$Windows NT$"

[NewRequest]

Subject = "CN=PFSV1.PoliForma.nl,OU=Testafdelingen,DC=PFSV1,DC=PoliForma,DC=nl,O=PoliForma,L=Gent,S=Oost-Vlaanderen,C=BE"
;
KeySpec = 1
KeyLength = 2048
Exportable = TRUE
MachineKeySet = TRUE
SMIME = False
PrivateKeyArchive = FALSE
UserProtected = FALSE
UseExistingKeySet = FALSE
ProviderName = "Microsoft RSA SChannel Cryptographic Provider"
ProviderType = 12
RequestType = PKCS10
KeyUsage = 0xa0

[EnhancedKeyUsageExtension]

OID=1.3.6.1.5.5.7.3.1 ; this is for Server Authentication
```

1. Sla bovenstaande tekst (juiste gegevens aanvullen in Subject) op met bestandsextensie .inf (_poliformacertreq.inf_)
2. In CLI: `certreq -new poliformacertreq.inf poliformacertreq.csr`

###4. Certificaat aanmaken (CA)

1. _poliformacertreq.csr_ beschikbaar maken op CA-machine in folder _CA_/certreqs
2. navigeer naar folder _CA_
3. `openssl ca -config openssl.cnf -infiles certreqs/poliformacertreq.csr`  
   Informatie nakijken (kijk ook eens naar het serienummer, dit wordt de naam van het certificaat), als alles klopt > y
4. Certificaat aangemaakt in _CA_/certsdb. De naam van het certificaat is het serienummer dat automatisch gegenereerd is.

###5. Certificaat importeren in WinServer

1. Certificaat aangemaakt met het CSR beschikbaar maken op de server.
2. Run > `mmc` > File > Add/Remove snap-in > Certificates > Add > OK (of open opgeslagen console)
3. Procedure analoog aan titel 2, maar dan in de container Personal 

###6. LDAPS-verbinding testen

1. Run > `ldp`
2. Connection > Connect...
3. Server name: _PFSV1.PoliForma.nl_ ; Port: `636` ; `SSL` aanvinken > OK

###7. Beveiligde verbinding voor LDAP-lookup owncloud

In de LDAP-sectie van het Admin-paneel, tabblad Server: zet vóór de hostnaam `ldaps://` en vul bij port in `636`

##TODO Openssl: versie controleren en indien nodig updaten

`openssl version`

**Bestanden kopiëren van en naar VM's**  
Guest Additions moeten geïnstalleerd zijn.
In principe kan je dit eenvoudig doen via een USB-stick: Menu Devices > USB devices > kies de stick. Let op! De drive wordt ge-unmount in het hostsysteem dus zorg ervoor dat er geen operaties bezig zijn!  
Soms (in mijn ervaring vaak bij Windows-guests) loopt er ergens iets mis en kan de guest de stick niet mounten. Dan moet je via shared folders werken.

1. Share toevoegen: Settings > Shared Folders
2. Share mounten (Windows-guest): net use x: \\vboxsrv\_sharenaam_  
   x is een driveletter die je zelf kiest maar die uiteraard nog niet in gebruik mag zijn.

Referenties:
 https://www.digitalocean.com/community/tutorials/openssl-essentials-working-with-ssl-certificates-private-keys-and-csrs
 http://www.javaxt.com/Tutorials/Windows/How_to_Enable_LDAPS_in_Active_Directory
 http://www.phildev.net/ssl

##Owncloud https (verbinding met owncloudserver via SSL)

//TODO