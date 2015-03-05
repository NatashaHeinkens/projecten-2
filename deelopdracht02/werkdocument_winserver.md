##WISA deel 1: ontwikkelomgeving

###Installatie Windows Server, IIS, SQL Server Express, .NET
  
Redenen voor de keuze voor een Vagrantbox:
* het opbouwen van de base box hoeft maar 1 keer -> bespaart veel tijd 
* je kan die box, met evte configuratie via shellscript/cms doorgeven aan alle ontwikkelaars en ze is dan eenvoudig via vagrant op te zetten

Ik heb zoals je weet [dit artikel][tutorial virtualisatie] gevolgd. Het maakt gebruik van [deze scripts] [joefitzgerald]. Er zit ook al een basis-vagrantfile bij die werkt met de box die het script opzet, en die we verder kunnen aanpassen.
Use case 1 beschrijft het opzetten van een basisinstallatie van windows server. We kunnen de installatie van IIS (via shell script) en SQL Server Express (via chocolatey) hier later nog in integreren. Dan zitten die al in de base box en is de eenvormigheid van de ontwikkelomgeving dus gegarandeerd. Nadeel hiervan is natuurlijk dat je mogelijk een volledig nieuwe base box moet bouwen als je de omgeving (drastisch) moet wijzigen, maar opnieuw, dit hoeft dan maar 1 keer.  

Op het moment dat ik dit schrijf, heb ik met de packer-scripts een win server 2012 r2 vagrantbox gebouwd met updates. Bij vagrant up wordt deze m.b.v. een powershell-script voorzien van IIS en SQL Server Express. Momenteel ben ik bezig met het automatiseren van de configuratie van SQL Server.  

Natuurlijk is het volledig handmatig opzetten van de hele configuratie ook nog een (zeer tijdrovende) optie, maar ik zou het persoonlijk graag zien werken met de vagrantbox :)

###Stappenplan voor het opzetten van de vagrantbox

Je hebt nodig:
* het archief packer-windows (uitpakken)
* als je geen evaluatieversie wil installeren, maar bvb de iso wil gebruiken die we vorig semester in Besturingssystemen gebruikt hebben:
   * deze iso
   * een md5-checksum voor deze iso
   * je license key voor deze installatie
   
Eigen iso gebruiken of windows updates overslaan: zie onderaan.  

1. [Download] (https://www.packer.io/downloads.html) en [installeer] (https://www.packer.io/docs/installation.html) Packer.
2. Open een command prompt en navigeer naar de folder packer-windows.
3. Als je iets veranderd hebt aan windows_2012_r2.json, valideer het bestand dan even: `packer validate .\windows_2012_r2.json`  
   Verbeter eventuele fouten.  
   Verander **niet** de `ssh_wait_timeout`! In principe kan je `headless` op false zetten, dan zie je de installatieschermen terwijl windows geïnstalleerd wordt, maar het kan leiden tot problemen met de ssh-connectie waardoor de installatie mislukt. Dus: je doet dit beter niet.
4. Run het commando `packer build .\windows_2012_r2.json`
5. Wacht (lang). Als je de installatie headless doet, zal je alleen de command prompt zien, er staat daar heel lang `Waiting for SSH to become available...`, het lijkt alsof er niets gebeurt. Het hele installatieproces (+ winupdate) wordt nu doorlopen. Ga maar een paar uur iets anders doen :)
6. Het resultaat: bestand windows_2012_r2_virtualbox.box in de folder packer-windows.

**Als je je eigen iso wil gebruiken**

1. Vervang in het bestand windows_2012_r2.json bij `iso_url` de link door het pad naar je iso
2. Vervang in datzelfde bestand bij `iso_checksum` de string door de checksum voor je iso
3. Vervang in Autounattend.xml (map answer_files) de tekst in de tag `<Key>` door jouw licentiesleutel en uncomment deze tag

**Als je geen windows updates wil installeren**

1. Uncomment in Autounattend.xml de sectie WITHOUT WINDOWS UPDATES (lijn 237 e.v.)
2. Comment de sectie daaronder WITH WINDOWS UPDATES

###Configuratie IIS/SQL Server
De firewall in Windows Server laat HTTP-verkeer door op poort 80. Usernames en paswoorden (vagrant/vagrant) moeten uiteraard anders op de productieserver.
Aan de basisconfiguratie van IIS heb ik niets gewijzigd. Out of the box is deze geconfigureerd met anonymous access onder beperkte permissies.
Als database-optie is er SQL Server (weliswaar de Express-versie voor de development box). Deze wordt geprovisioneerd met:
*l/p: VAGRANT/PASSWORD1$ (voor de development box, dit moet natuurlijk anders op de productieserver)
*databasenaam: TESTDB 

###Development + Vagrant
Als we eens een vagrantbox hebben, is het heel eenvoudig om deze door te geven. Het zou volledig analoog verlopen aan de [vagrant basistutorial] [vagrantup]. Aangemaakte box dan doorgeven of ergens hosten.

Je hebt nodig:
* De Vagrantbox aangemaakt in het stappenplan hierboven.
* Het archief test-project, uitgepakt (bestanden Vagrantfile, install.ps1 en sql_config.sql) in een projectmap.

1. [Download] (http://www.vagrantup.com/downloads) en [installeer] (http://docs.vagrantup.com/v2/installation/index.html) Vagrant.
2. Open een command prompt en navigeer naar de folder waar je windows_2012_r2_virtualbox.box hebt opgeslagen en typ `vagrant box add WinServer2012R2 .\windows_2012_r2_virtualbox.box`.  
   De naam WinServer2012R2 is belangrijk, neem deze exact over inclusief hoofdletters.
3. Controleer of stap 2 succesvol is geweest met het commando `vagrant box list`. In deze lijst staat nu een box met de juiste naam.
4. Navigeer naar de folder waar de bestanden uit het archief test-project staan en voer het commando `vagrant up` in. Nu wordt een virtuele machine opgezet en IIS en SQL Server worden geïnstalleerd. Dit kan dus even duren.
5. Resultaat: een VM die in de achtergrond draait onder VirtualBox.

Je kan de desktop van deze box oproepen met het commando `vagrant rdp`.
Je kan de box afsluiten met: 
* `vagrant suspend` (inhoud van het geheugen van de box wordt bijgehouden, dit neemt dus meer plaats in maar de box hervatten gaat wel sneller)
* `vagrant halt` (dit sluit de virtuele machine gecontroleerd af)

De box vernietigen doe je met `vagrant destroy` (alle provisionering gaat verloren, de volgende keer dat je `vagrant up` doet begint het hele proces van voorafaan)
In de drie gevallen kan je de box opnieuw opstarten met `vagrant up`.

##WISA deel 2: deployment
Voor *windows + gratis* lijken met de beste opties: 
* amazon web services: http://aws.amazon.com/free/   
* azure: http://www.microsoftazurepass.com/azureu -> dit moet dan wel via mr. Van Vreckem, meer informatie volgt.

[tutorial virtualisatie]: http://www.developer.com/net/virtualize-your-windows-development-environments-with-vagrant-packer-and-chocolatey-part-1.html
[joefitzgerald]: https://github.com/joefitzgerald/packer-windows
[kensykora]: https://atlas.hashicorp.com/kensykora/boxes/windows_2012_r2_standard
[vagrantup]: http://docs.vagrantup.com/v2/getting-started/index.html




   
