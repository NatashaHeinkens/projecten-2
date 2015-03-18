#Test Rapport WISA

  * **Stap 1.** De vagrantbox is aangemaakt. Dit hebben we gerealiseerd door het stappenplan te volgen.
  ![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht02/wisa_files/screenshots/stap 1.jpg "stap1")
  * **Stap 2.** Het opzetten van de VM is geautomatiseerd. Dit hebben we gerealiseerd door de handeleiding voor de gebruikers te volgen ([zie documentatie](https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht02/documentatie_winserver.md)).
   ![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht02/wisa_files/screenshots/stap 2.jpg "stap2")
  * **Stap 3.** De geinstalleerde versies van de features zijn:
       * IIS(Version 8.5.9600.16384): Server manager > Tools > ISS manager > Help > about
      ![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht02/wisa_files/screenshots/stap 3-1.jpg "stap3-1")
       * ASP.NET 4.5: Server manager > manage > add roles and features > features 
     ![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht02/wisa_files/screenshots/stap 3-2.jpg "stap3-2")
       * SQL Server Express 2014 (-12.0.2000.8): powershell as administrator > `import-module sqlps` > `Set-Location SQLSERVER:\SQL\VAGRANT-2012-R2\SQLEXPRESS` > `invoke-sqlcmd -query "select @@version"` 
      ![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht02/wisa_files/screenshots/stap 3-3.jpg "stap3-3")
  * **stap 4.**  De VM is geconfigureerd om de laatste updates te installeren.  
    Server manager > local server
       ![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht02/wisa_files/screenshots/stap 4.jpg "stap4")
  * **stap 5.** De firewall staat aan. De firewall instellingen zijn te controleren door in de search naar 'windows firewall' (of firewall) in te geven en kies "Windows firewall with afvanced security settings" : 'Firewall is on'
  ![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht02/wisa_files/screenshots/stap 5.jpg "stap5")
  * **stap 6.** Alle poorten zijn geconfigureerd. Om de poorten te controleren hebben we dezelfde window nodig als uit de vorige stap, van daar uit gaan we naar 'inbound rules'. Hierin staan alle opgenomen poorten in opgesomd.
   ![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht02/wisa_files/screenshots/stap 6.jpg "stap6")
  * **stap 7** Een SSH verbinding is gemaakt en een gui krijgen we te zien na het ingeven van de rdp commando. Via de console geven we `vagrant ssh` in > `exit` > `vagrant rdp`
  ![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht02/wisa_files/screenshots/stap 7.jpg "stap7")
  * **stap 8** Er is een map van het hostsysteem gemount op de VM. Dit kunnen we gemakkelijk controleren door in de verkenner te gaan naar de c-schijf waar we een shared folder te zien moeten krijgen.
![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht02/wisa_files/screenshots/stap 8.jpg "stap8")
