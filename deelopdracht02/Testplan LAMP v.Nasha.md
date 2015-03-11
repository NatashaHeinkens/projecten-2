#Testplan LAMP stack

##Prerequisites
  Alles is geinstalleerd van Prerequisites.

##Stappenplan
**Stap 1.**
  * De box is geadd. Als je vagrant box list doet verschijnt de box in de lijst.  
  
**Stap 2.**
  * De vagrantfile is aangepast.
  * De inventory_dev file is aangepast.
  * De vagrant_hosts.yml file is aangepast.
  * De roles zijn gedefinieerd.
	  1. common/main.yml is aangepast
	  1. lamp/main.yml is aangepast
  * De site.yml file is aangepast.  
  
**Stap 3.**
  * De machine is opgestart via `vagrant up`  
  
**Stap 4.**
  * De SSH is verkregen via `vagrant SSH`  
  
**Stap 5.**
  * De apache test pagina is te zien als men naar http://http://192.168.56.10 surft.
