import-module servermanager
add-windowsfeature web-server -includeallsubfeature

#SQL Server en Webdeploy
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
choco install mssqlserver2014express -version 1.0.5
choco install webdeploy
