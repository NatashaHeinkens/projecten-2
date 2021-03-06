##WISA deel 1: ontwikkelomgeving

###Stappenplan voor het opzetten van de vagrantbox

Ik heb zoals je weet [dit artikel][tutorial virtualisatie] gevolgd. Het maakt gebruik van [deze scripts] [joefitzgerald]. Er zit ook al een basis-vagrantfile bij die werkt met de box die het script opzet, en die we verder kunnen aanpassen.

Je hebt nodig:
* de map [packer-windows] (/deelopdracht02/wisa/packer-windows) + inhoud
* als je geen evaluatieversie wil installeren, maar een eigen iso wil gebruiken:
   * deze iso
   * een md5-checksum voor deze iso
   * je license key voor deze installatie
   
Eigen iso gebruiken of windows updates overslaan: zie onderaan.  

1. [Download] (https://www.packer.io/downloads.html) en [installeer] (https://www.packer.io/docs/installation.html) Packer.
2. Open een command prompt en navigeer naar de folder packer-windows.
3. Als je iets veranderd hebt aan windows_2012_r2.json, valideer het bestand dan even: `packer validate .\windows_2012_r2.json`  
   Verbeter eventuele fouten.  
   Verander **niet** de `ssh_wait_timeout`, tenzij om de timeout langer te maken! In principe kan je `headless` op false zetten, dan zie je de installatieschermen terwijl windows geïnstalleerd wordt, maar het kan leiden tot problemen met de ssh-connectie waardoor de installatie mislukt. Dus: je doet dit beter niet.
4. Run het commando `packer build .\windows_2012_r2.json`. Je kan ook het commando `packer build -debug .\windows_2012_r2.json` gebruiken, dan moet je bij elke stap in het build-proces bevestiging geven.
5. Wacht (lang). Als je de installatie headless doet, zal je alleen de command prompt zien, er staat daar heel lang `Waiting for SSH to become available...`, het lijkt alsof er niets gebeurt. Het hele installatieproces (+ winupdate) wordt nu doorlopen. Ga maar een paar uur iets anders doen :)
6. Het resultaat: bestand windows_2012_r2_virtualbox.box in de folder packer-windows.


**Als je je eigen iso wil gebruiken**

1. Vervang in het bestand windows_2012_r2.json bij `iso_url` de link door het pad naar je iso
2. Vervang in datzelfde bestand bij `iso_checksum` de string door de checksum voor je iso
3. Vervang in Autounattend.xml (map answer_files) de tekst in de tag `<Key>` door jouw licentiesleutel en uncomment deze tag

**Als je geen windows updates wil installeren**

1. Uncomment in Autounattend.xml de sectie WITHOUT WINDOWS UPDATES (lijn 237 e.v.)
2. Comment de sectie daaronder WITH WINDOWS UPDATES


###Gebruik van de Vagrantbox: handleiding voor de gebruiker

####Box opstarten
Je hebt nodig:
* De Vagrantbox aangemaakt in het stappenplan hierboven.
* De bestanden uit de map [vagrant-windows] (/deelopdracht02/wisa/vagrant-windows) (bestanden Vagrantfile en install.ps1 ) in een projectmap.

1. [Download] (http://www.vagrantup.com/downloads) en [installeer] (http://docs.vagrantup.com/v2/installation/index.html) Vagrant.
2. Open een command prompt en navigeer naar de folder waar je windows_2012_r2_virtualbox.box hebt opgeslagen en typ `vagrant box add WinServer2012R2 .\windows_2012_r2_virtualbox.box`.  
   De naam WinServer2012R2 is belangrijk, neem deze exact over inclusief hoofdletters. Deze naam moet hetzelfde zijn als de boxnaam in de vagrantfile: `config.vm.box = "WinServer2012R2"` 
3. Controleer of stap 2 succesvol is geweest met het commando `vagrant box list`. In deze lijst staat nu een box met de juiste naam.
4. Navigeer naar de folder waar de bestanden uit de map vagrant-windows staan en voer het commando `vagrant up` in. Nu wordt een virtuele machine opgezet en IIS en SQL Server worden geïnstalleerd. Dit kan dus even duren.
5. Resultaat: een VM die in de achtergrond draait onder VirtualBox. 

####Box gebruiken
De folder waarin de Vagrantfile staat, is op de VM gemount in de map C:\vagrant. Er is port forwarding voorzien van poort 8080 (host) naar poort 80 (guest). Deployment gebeurt naar 127.0.0.1:8080 met l/p vagrant/vagrant. Na deployment van de webapplicatie kan je op de host surfen naar http://127.0.0.1:8080 om de site, die je serveert op de guest, te bekijken.

Je kan de desktop van de VM oproepen met het commando `vagrant rdp`. Inloggen met l/p: vagrant/vagrant.  
Vanop een Linux-host kan je niet rdp'en naar de machine (tenzij je daarvoor de juiste software, zoals rdesktop, installeert). In plaats daarvan kan je de VM zichtbaar draaien (een vm-venster zoals je krijgt wanneer je een VM opstart in VirtualBOX zelf). Werkwijze:  
* in de Vagrantfile: uncomment de lijn `v.gui = true`

Je kan de box afsluiten met: 
* `vagrant suspend` (inhoud van het geheugen van de box wordt bijgehouden, dit neemt dus meer plaats in maar de box hervatten gaat wel sneller)
* `vagrant halt` (dit sluit de virtuele machine gecontroleerd af)

De box vernietigen doe je met `vagrant destroy` (alle provisionering gaat verloren, de volgende keer dat je `vagrant up` doet begint het hele proces van bij het begin)
In de drie gevallen kan je de box opnieuw opstarten met `vagrant up`.

###Configuratie VM

* De box aangemaakt in het stappenplan is Windows Server 2012 R2 met de laatste updates. Deze is ook geconfigureerd voor automatische updates.
* Configuratie van IIS: anonymous access onder beperkte permissies, DefaultAppPool is geconfigureerd voor .NET v4.0.
* Als database-optie is er SQL Server (weliswaar de Express-versie). 
* Tenslotte is ook Web Deploy geïnstalleerd om deployment vanuit Visual Studio te vergemakkelijken.
* De firewall in Windows Server laat HTTP-verkeer door op poort 80, SSL op poort 443. Ook voor OpenSSH en RDP zijn de nodige poorten geopend (voor Vagrant). Daarnaast is poort 8172 geopend (voor Web Deploy).
* Usernames en paswoorden (vagrant/vagrant) moeten uiteraard anders op de productieserver.  



##WISA deel 2: productie

###Opzetten van de Azure VM

Je hebt nodig:
* Een Azure account

1. Log in op de Azure Management Portal
2. Kies in de lijst links `Virtual Machines` en klik op `Create new VM` of links onderaan op `New`
3. `Compute` > `Virtual Machine` > `From Gallery` 
4. Image: Windows Server 2012 R2 Datacenter
5. Kies een naam voor de machine, Basic Tier, Size A0; kies een username en een **sterk** paswoord
6. Kies `Create a new cloud service`, kies een dns-naam, Regio West Europe

Eens de VM draait, kan je ermee verbinden door onderaan in het managementportaal `Connect` te kiezen. Het rdp-bestand, dat je dan downloadt, openen en l/p ingeven. Het certificaat aanvaarden.

###IIS en SQL Server Express installeren

1. Maak een rdp-verbinding met de VM.
2. Copy-paste het script install.ps1 (uit de map vagrant-windows, zie boven) naar de VM.
3. Open op de VM Powershell als administrator en navigeer naar de plaats waar je het script hebt opgeslagen.
4. Voer het commando `.\install.ps1` uit.

###Endpoints creëren voor Web Deploy en HTTP

**Web Deploy**  

1. Klik in de management portal op de VM-naam, kies de sectie Endpoints, kies onderaan Add
2. Kies `Add a stand-alone endpoint`
3. Geef als naam `Web Deploy` in
4. Protocol: TCP
5. Public port en Private port: 8172

**HTTP**  

1. Klik in de management portal op de VM-naam, kies de sectie Endpoints, kies onderaan Add
2. Kies `Add a stand-alone endpoint`
3. Kies het voorgedefinieerde endpoint `HTTP` uit de lijst

###Deployment naar de productieserver via Web Deploy: handleiding voor de gebruiker  

* Server: Geef hier het virtual public ip van de VM in (te vinden bij de ge het Azure managementportaal)
* User name en Password: zoals gekozen bij het aanmaken van de VM


[tutorial virtualisatie]: http://www.developer.com/net/virtualize-your-windows-development-environments-with-vagrant-packer-and-chocolatey-part-1.html
[joefitzgerald]: https://github.com/joefitzgerald/packer-windows
[vagrantup]: http://docs.vagrantup.com/v2/getting-started/index.html




   
