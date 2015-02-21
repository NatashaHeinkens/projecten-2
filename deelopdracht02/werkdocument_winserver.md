##WISA deel 1: ontwikkelomgeving

###Installatie Windows Server, IIS, MySQL, .NET
Zoals we donderdag besproken hebben lijkt het me goed om te proberen om met packer een vagrantbox te maken.  
Redenen:
* het opbouwen van zo'n box hoeft maar 1 keer -> bespaart veel tijd
* je kan die box, met evte configuratie via shellscript/cms doorgeven aan alle ontwikkelaars en ze is dan eenvoudig via vagrant op te zetten

Ik heb zoals je weet [dit artikel][tutorial virtualisatie] gevolgd. Het maakt gebruik van [deze scripts] [joefitzgerald]. Er zit ook al een basis-vagrantfile bij die werkt met de box die het script opzet, en die we verder kunnen aanpassen.
Use case 1 beschrijft het opzetten van een basisinstallatie van windows server. We kunnen evt proberen om de installatie van IIS (via shell script) en MySQL (via chocolatey) hierin te integreren. Dan zitten die al in de base box en is de eenvormigheid van de ontwikkelomgeving dus gegarandeerd. Nadeel hiervan is natuurlijk dat je mogelijk een volledig nieuwe base box moet bouwen als je de omgeving (drastisch) moet wijzigen, maar opnieuw, dit hoeft dan maar 1 keer.  
De scriptjes hiervoor heb ik al geschreven obv de informatie uit uc2+3+4 van de tutorial, maar ik heb ze nog niet getest.
Op het moment dat ik dit schrijf, heb ik met de packer-scripts een win server 2012 r2 vagrantbox gebouwd zonder updates en IIS/MySQL, bij wijze van test. Dat lukt zonder problemen, het resultaat is 8,2 GB groot. Als we ons testplan uitgewerkt hebben, ga ik het eens opnieuw proberen met een box met volledige WISA-stack.  
Als het opbouwen van een eigen base box niet lukt, kunnen we evt overwegen [deze][kensykora] te gebruiken. We moeten die dan evenzeer nog wel via de shell of cms-software provisioneren, of handmatig configureren.

En natuurlijk is het volledig handmatig opzetten van de hele configuratie ook nog een (zeer tijdrovende) optie, maar ik zou het persoonlijk graag zien werken met de vagrantbox :)

###Configuratie IIS/MySQL
Over _welke_ configuratie-instellingen precies nodig zijn qua beveiliging, heb ik nog geen opzoekingswerk gedaan. Tips?
Over _wat_ we kunnen gebruiken voor config: ik ben nu aan het kijken naar puppet (configuration management software zoals ansible). Dat lijkt op het eerste zicht een veelbelovende optie omdat er vele voorgedefinieerde modules zijn om windows vm's te beheren, ondermeer voor IIS en MySQL. En het zou ook te gebruiken zijn op Azure, als we in die richting gaan voor deployment (zie onder).  
In de scripts voor packer staat ook een script voor de installatie van de puppet agent. Dus die zou gelijk meekunnen op de vagrantbox.  
Ik ben hier zelf nog niet in detail ingedoken, [hier] [puppetwindows] is een beginpunt.

###Development + Vagrant
Als we eens een geprovisioneerde vagrantbox hebben, is het heel eenvoudig om deze door te geven. Het zou volledig analoog verlopen aan de [vagrant basistutorial] [vagrantup]. Aangemaakte box dan doorgeven of ergens hosten.

[tutorial virtualisatie]: http://www.developer.com/net/virtualize-your-windows-development-environments-with-vagrant-packer-and-chocolatey-part-1.html
[joefitzgerald]: https://github.com/joefitzgerald/packer-windows
[kensykora]: https://atlas.hashicorp.com/kensykora/boxes/windows_2012_r2_standard
[puppetwindows]: https://docs.puppetlabs.com/windows/
[vagrantup]: http://docs.vagrantup.com/v2/getting-started/index.html

##WISA deel 2: deployment
Voor *windows + gratis* lijken met de beste opties: 
* amazon web services: http://aws.amazon.com/free/
   * ec2 + puppet: http://puppetlabs.com/solutions/ec2
* azure: http://www.microsoftazurepass.com/azureu -> dit moet dan wel via mr. Van Vreckem, dat moeten we hem eens vragen.
   * azure + puppet: http://puppetlabs.com/solutions/microsoft
