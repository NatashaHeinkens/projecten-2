##WISA deel 1: ontwikkelomgeving

###Installatie Windows Server, IIS, MySQL, .NET
Zoals we donderdag besproken hebben lijkt het me goed om te proberen om met packer een vagrantbox te maken.  
Redenen:
* het opbouwen van zo'n box hoeft maar 1 keer -> bespaart veel tijd
* je kan die box, met evte configuratie via shellscript/cms doorgeven aan alle ontwikkelaars en ze is dan eenvoudig via vagrant op te zetten

Ik heb zoals je weet [dit artikel][tutorial virtualisatie] gevolgd. Het maakt gebruik van [deze scripts] [joefitzgerald]. Er zit ook al een basis-vagrantfile bij die werkt met de box die het script opzet, en die we verder kunnen aanpassen.
Use case 1 beschrijft het opzetten van een basisinstallatie van windows server. We kunnen evt proberen om de installatie van IIS (via shell script) en MySQL (via chocolatey) hierin te integreren. Dan zitten die al in de base box en is de eenvormigheid van de ontwikkelomgeving dus gegarandeerd. Nadeel hiervan is natuurlijk dat je mogelijk een volledig nieuwe base box moet bouwen als je de omgeving (drastisch) moet wijzigen, maar opnieuw, dit hoeft dan maar 1 keer.  
De scriptjes hiervoor heb ik al geschreven obv de informatie uit uc2+3+4 van de tutorial, maar ik heb ze nog niet getest.
Op het moment dat ik dit schrijf, heb ik met de packer-scripts een win server 2012 r2 vagrantbox gebouwd met updates en IIS/MySQL, bij wijze van test. Dat lukt zonder problemen, het resultaat is 8,7 GB groot. Als we ons testplan uitgewerkt hebben, ga ik het eens opnieuw proberen met een box met volledige WISA-stack.  

Natuurlijk is het volledig handmatig opzetten van de hele configuratie ook nog een (zeer tijdrovende) optie, maar ik zou het persoonlijk graag zien werken met de vagrantbox :)

###Configuratie IIS/MySQL
Over _welke_ configuratie-instellingen precies nodig zijn qua beveiliging, heb ik nog geen opzoekingswerk gedaan. Tips?

###Development + Vagrant
Als we eens een geprovisioneerde vagrantbox hebben, is het heel eenvoudig om deze door te geven. Het zou volledig analoog verlopen aan de [vagrant basistutorial] [vagrantup]. Aangemaakte box dan doorgeven of ergens hosten.

[tutorial virtualisatie]: http://www.developer.com/net/virtualize-your-windows-development-environments-with-vagrant-packer-and-chocolatey-part-1.html
[joefitzgerald]: https://github.com/joefitzgerald/packer-windows
[kensykora]: https://atlas.hashicorp.com/kensykora/boxes/windows_2012_r2_standard
[vagrantup]: http://docs.vagrantup.com/v2/getting-started/index.html

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

##WISA deel 2: deployment
Voor *windows + gratis* lijken met de beste opties: 
* amazon web services: http://aws.amazon.com/free/
   * ec2 + puppet: http://puppetlabs.com/solutions/ec2
* azure: http://www.microsoftazurepass.com/azureu -> dit moet dan wel via mr. Van Vreckem, meer informatie volgt.
   * azure + puppet: http://puppetlabs.com/solutions/microsoft
