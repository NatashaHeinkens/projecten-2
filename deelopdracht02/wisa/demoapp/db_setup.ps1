Import-Module SqlPs
Set-Location SQLSERVER:\SQL\vm-001\SQLEXPRESS
Invoke-Sqlcmd -InputFile "C:\Users\klant_testproject\createdb_contoso.sql"
Set-Location SQLSERVER:\SQL\vm-001\SQLEXPRESS\Databases\ContosoUniversity
Invoke-Sqlcmd -InputFile "C:\Users\klant_testproject\Grant.sql"
