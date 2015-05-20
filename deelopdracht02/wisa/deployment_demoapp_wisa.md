####Deployment van de demo-app ContosoUniversity

De installatie van Windows Server volgens [het stappenplan] (/blob/master/deelopdracht02/wisa/documentatie_wisa.md) installeert ook Web Deploy. Het is dus mogelijk voor de webontwikkelaar om de app rechtstreeks vanuit Visual Studio te publiceren. Meer informatie hierover vind je [hier] (http://www.asp.net/whitepapers/aspnet-web-deployment-content-map).

Om de installatie van de demo-app te vergemakkelijken doen we dit via een deployment package. Je hebt hiervoor Visual Studio niet nodig. De stappen zijn dezelfde voor deployment naar testomgeving en naar productieomgeving, je moet wel het database-setupscript aanpassen met de juiste computernaam en bestandlocaties (zie onder).

Je hebt nodig:

* Een rdp-verbinding met de VM (in het stappenplan staat hoe je deze kan aanmaken voor beide omgevingen)
* De map [contoso_packagedeploy] (/deelopdracht02/wisa/demoapp/contoso_packagedeploy) met inhoud op een locatie beschikbaar voor de VM
   * Voor de developmentomgeving (aangemaakt volgens het stappenplan): de projectmap waarin je `vagrant up` uitvoert (deze is op de VM beschikbaar onder C:\vagrant)
   * Voor de productieomgeving: maak een rdp-verbinding met de VM (zie stappenplan) en copy-paste de map
* De bestanden [db_setup.ps1] (/deelopdracht02/wisa/demoapp/db_setup.ps1), [createdb_contoso.sql] (/deelopdracht02/wisa/demoapp/createdb_contoso.sql) en [grant_contoso.sql](/deelopdracht02/wisa/demoapp/grant_contoso.sql) op een locatie beschikbaar voor de VM

#####Stap 1: Database en databasegebruiker aanmaken

De demo-app ContosoUniversity (afkomstig van Microsoft) bevat twee databases: de ene is geconfigureerd voor Code Migrations, de andere is een asp.net-gebruikersdatabase. In deze demo nemen we alleen de eerste database mee in deployment. Alleen dié functies waarvoor je niet moet inloggen zullen werken in de demoapp.

1. Pas het script db_setup.ps1 aan indien nodig. Voor de developmentmachine is dit niet nodig als je het stappenplan exact gevolgd hebt.
   * `Set-Location SQLSERVER:\SQL\vagrant-2012-r2\SQLEXPRESS`: vagrant-2012-r2 is de naam van de VM, pas deze aan indien nodig.  
      Je vindt de computernaam onder andere via rechtsklik op het Windows-logo > System  
      ![alt] (/deelopdracht02/wisa/screenshots/demoapp_stap1.png "Computernaam")
   * `Set-Location SQLSERVER:\SQL\vagrant-2012-r2\SQLEXPRESS\Databases\ContosoUniversity`: idem (computernaam invullen)
   * `Invoke-Sqlcmd -InputFile "C:\vagrant\createdb_contoso.sql"`: C:\vagrant is het absolute pad naar de map waar je de sql-scripts hebt neergezet, pas dit aan indien nodig.
   * `Invoke-Sqlcmd -InputFile "C:\vagrant\Grant.sql"`: idem (pad invullen)
2. Run het script db_setup.ps1
   * Open Powershell als Administrator.
   * Navigeer naar de plaats waar je het script db_setup.ps1 hebt gezet
   * Voer het script uit: `.\db_setup.ps1`. Vergeet `.\` niet!
3. Resultaat: de database wordt aangemaakt op de server. Daarnaast krijgt de webapplicatie toegang tot deze database.

#####Stap 2: App publiceren

1. Open IIS Manager op de VM: Run > geef het commando 'inetmgr' in
2. Klap de gegevens van de server uit > Sites > klik op Default Web Site
3. Klik rechts beneden op 'Import application...'  
   ![alt] (/deelopdracht02/wisa/screenshots/demoapp_stap2-3.png "Import application")
4. Geef de locatie van het zip-bestand in de map contoso_packagedeploy  (Browse...) > Next
   ![alt] (/deelopdracht02/wisa/screenshots/demoapp_stap2-4.png "zipfile-locatie")
5. Laat alles geselecteerd staan > Next
   ![alt] (/deelopdracht02/wisa/screenshots/demoapp_stap2-5.png "Selecteer inhoud")
6. Kies een naam voor de applicatie, bijvoorbeeld ContosoUniversity > Next (deze naam maakt later deel uit van de url). Hier zie je ook de connection strings voor de database. 
   ![alt] (/deelopdracht02/wisa/screenshots/demoapp_stap2-6.png "Selecteer naam")
7. Als de applicatienaam die je gekozen hebt nog niet bestaat, begint nu de installatie. Anders vraagt het systeem je nog of je de bestanden wil overschrijven.  Als je voor ja kiest, wordt de hele applicatie vervangen. Bij nee worden enkel bestanden toegevoegd, niets verwijderd.  
   ![alt] (/deelopdracht02/wisa/screenshots/demoapp_stap2-7.png "Vervangen of niet")
8. Resultaat: de applicatie wordt nu toegevoegd aan de Default Web Site. Je krijgt een samenvatting van het proces.  
   ![alt] (/deelopdracht02/wisa/screenshots/demoapp_stap2-8.png "Samenvatting")

#####Stap 3: Surfen naar de applicatie

* Op de lokale VM: als je de stappenplannen voor installatie van de VM en publicate van de demoapp gevolgd hebt, kan je op de host surfen naar 127.0.0.1:8080/ContosoUniversity (de naam van de app die je in stap 2 hebt gekozen)
* Op de Azure-VM: log in op de Azure Management Portal en haal het Dashboard van de VM voor je. In de kolom rechts (Quick glance) vind je het public virtual ip address van de VM. Je kan surfen naar _publicvipaddress_/ContosoUniversity (de naam van de app die je in stap 2 hebt gekozen)  
   Let op! Dit werkt natuurlijk alleen als je een endpoint voor HTTP hebt gecreëerd voor deze VM! In het [stappenplan] (/deelopdracht02/wisa/documentatie_wisa.md) kan je lezen hoe dit moet.
