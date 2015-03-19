#Prerequisites
  * Een box met [CentOS 7 min. install](https://f0fff3908f081cb6461b407be80daf97f07ac418.googledrive.com/host/0BwtuV7VyVTSkUG1PM3pCeDJ4dVE/centos7.box)
  * Werkende Vagrant
  * Werkende Ansible
  * Vagrant en Ansible werken samen (zie [skeleton](https://github.com/bertvv/ansible-skeleton "Dhr Van Vreckem's github"))
  * Oracle VirtualBox is geïnstalleerd
  * Ruby en Python zijn geïnstalleerd (voor ansible en de skeleton)

#Stappenplan
1. Zorg voor een werkende guest-machine (CentOS 7 Minimal install)
  1. Pas de vagrant_hosts.yml file aan als volgt:
    `- name: gekozenNaam`
    `(newline)  ip: xxx.xxx.xxx.xxx`
  2. (Opdat het ook zou werken op Windows-hosts) pas de ansible/inventory_dev file aan als volgt:
    `gekozenNaam`
  4. Voeg de minimal-box toe aan vagrant: `vagrant box add centos70-nocm`
2. Breng de machine een eerste keer up: `vagrant up`
  * Je kan testen of de machine effectief draaiend is door `vagrant ssh` uit te voeren, dan krijg je een ssh verbinding naar de guest.
  * Verlaat de ssh verbinding weer met het `exit` commando
3. Pas de ansible/site.yml file aan zoals te vinden op [github](https://github.com/HoGentTIN/ops-g-07/tree/master/Ansible/ansible/site.yml)
  * Let op dat je enkel de lijnen die gelden op de JEE-guest, overneemt.
4. Maak folders voor elk van de roles, en pas de files daarin aan zoals op [github](https://github.com/HoGentTIN/ops-g-07/tree/master/Ansible/ansible/)
  * common voor de veelvoorkomende benodigde packages
  

TODO
