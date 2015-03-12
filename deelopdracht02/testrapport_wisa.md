#Test Rapport WISA

  * **Stap 1.** De vagrantbox is aangemaakt. Dit hebben we gerealiseerd door het stappenplan te volgen.
  * **Stap 2.** Het opzetten van de VM is geautomatiseerd. Dit hebben we gerealiseerd door de handeleiding voor de gebruikers te volgen ([zie documentatie](https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht02/documentatie_winserver.md)).
  * **Stap 3.** De geinstalleerde versies van de features zijn:
       * IIS(Version 8.5.9600.16384): Server manager > Tools > ISS manager > Help > about
       * ASP.NET 4.5: Server manager > manage > add roles and features > features 
       * SQL Server Express 2014 (-12.0.2000.8): powershell as administrator > import-module sqlps > Set-Location SQLSERVER:\SQL\VAGRANT-2012-R2\SQLEXPRESS > invoke-sqlcmd -query "select @@version" 
  * **stap 4.**  De VM is geconfigureerd om de laatste updates te installeren.
