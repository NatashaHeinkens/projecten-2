Import-Module SqlPs
Set-Location SQLSERVER:\SQL\vagrant-2012-r2\SQLEXPRESS
Invoke-Sqlcmd -InputFile "C:\vagrant\createdb_contoso.sql"
Set-Location SQLSERVER:\SQL\vagrant-2012-r2\SQLEXPRESS\Databases\ContosoUniversity
Invoke-Sqlcmd -InputFile "C:\vagrant\Grant.sql"
