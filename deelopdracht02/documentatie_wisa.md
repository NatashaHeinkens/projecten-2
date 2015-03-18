##WISA deel 1: ontwikkelomgeving

###Stappenplan voor het opzetten van de vagrantbox

Ik heb zoals je weet [dit artikel][tutorial virtualisatie] gevolgd. Het maakt gebruik van [deze scripts] [joefitzgerald]. Er zit ook al een basis-vagrantfile bij die werkt met de box die het script opzet, en die we verder kunnen aanpassen.

Je hebt nodig:
* het archief [packer-windows] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht02/packer-windows.zip) (uitpakken)
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

Je hebt nodig:
* De Vagrantbox aangemaakt in het stappenplan hierboven.
* Het archief [vagrant-windows] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht02/vagrant-windows.zip), uitgepakt (bestanden Vagrantfile en install.ps1 ) in een projectmap.

1. [Download] (http://www.vagrantup.com/downloads) en [installeer] (http://docs.vagrantup.com/v2/installation/index.html) Vagrant.
2. Open een command prompt en navigeer naar de folder waar je windows_2012_r2_virtualbox.box hebt opgeslagen en typ `vagrant box add WinServer2012R2 .\windows_2012_r2_virtualbox.box`.  
   De naam WinServer2012R2 is belangrijk, neem deze exact over inclusief hoofdletters.
3. Controleer of stap 2 succesvol is geweest met het commando `vagrant box list`. In deze lijst staat nu een box met de juiste naam.
4. Navigeer naar de folder waar de bestanden uit het archief test-project staan en voer het commando `vagrant up` in. Nu wordt een virtuele machine opgezet en IIS en SQL Server worden geïnstalleerd. Dit kan dus even duren.
5. Resultaat: een VM die in de achtergrond draait onder VirtualBox. 


De folder waarin de Vagrantfile staat, is op de VM gemount in de map C:\vagrant. Er is port forwarding voorzien van poort 8080 (host) naar poort 80 (guest). Deployment gebeurt naar 127.0.0.1:8080 met l/p vagrant/vagrant. Na deployment van de webapplicatie kan je op de host surfen naar http://127.0.0.1:8080 om de site, die je serveert op de guest, te bekijken.

Je kan de desktop van de VM oproepen met het commando `vagrant rdp`. Inloggen met l/p: vagrant/vagrant.

Je kan de box afsluiten met: 
* `vagrant suspend` (inhoud van het geheugen van de box wordt bijgehouden, dit neemt dus meer plaats in maar de box hervatten gaat wel sneller)
* `vagrant halt` (dit sluit de virtuele machine gecontroleerd af)

De box vernietigen doe je met `vagrant destroy` (alle provisionering gaat verloren, de volgende keer dat je `vagrant up` doet begint het hele proces van bij het begin)
In de drie gevallen kan je de box opnieuw opstarten met `vagrant up`.

###Configuratie VM

* De box aangemaakt in het stappenplan is Windows Server 2012 R2 met de laatste updates. Deze is ook geconfigureerd voor automatische updates.
* De firewall in Windows Server laat HTTP-verkeer door op poort 80, SSL op poort 443. Ook voor OpenSSH en RDP zijn de nodige poorten geopend (voor Vagrant).
* Usernames en paswoorden (vagrant/vagrant) moeten uiteraard anders op de productieserver.
* Configuratie van IIS: anonymous access onder beperkte permissies, DefaultAppPool is geconfigureerd voor .NET v4.0.
* Als database-optie is er SQL Server (weliswaar de Express-versie). 


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

Eens de VM draait, kan je ermee verbinden door onderaan in het managementportaal `Connect` te kiezen. Het rdp-bestand, dat je dan downloadt, openen en credentials ingeven.

###IIS en SQL Server Express installeren

1. Maak een rdp-verbinding met de VM.
2. Copy-paste het script install.ps1 (uit het archief vagrant-windows, zie boven) naar de VM.
3. Open op de VM Powershell als administrator en navigeer naar de plaats waar je het script hebt opgeslagen.
4. Voer het commando `.\install.ps1` uit.

###Deployment naar de productieserver: handleiding voor de gebruiker
//TODO

[tutorial virtualisatie]: http://www.developer.com/net/virtualize-your-windows-development-environments-with-vagrant-packer-and-chocolatey-part-1.html
[joefitzgerald]: https://github.com/joefitzgerald/packer-windows
[vagrantup]: http://docs.vagrantup.com/v2/getting-started/index.html




   
