#Prerequisites
  * Draaiende host-machine
  * Werkende Vagrant
  * Werkende Ansible
  * Vagrant en Ansible werken samen (zie [skeleton](https://github.com/bertvv/ansible-skeleton "Dhr Van Vreckem's github")
  * Oracle VirtualBox is geïnstalleerd
  * Ruby en Python zijn geïnstalleerd (voor ansible en de skeleton)

#Stappenplan
1. Zorg voor een werkende guest-machine (CentOs 7 Minimal install)
  1. Pas de vagrant_hosts.yml file aan als volgt:
    `- name: gekozenNaam`
    `  ip: xxx.xxx.xxx.xxx`
  2. (Opdat het ook zou werken op Windows-hosts) pas de ansible/inventory_dev file aan als volgt:
    `gekozenNaam`
  3. Pas de ansible/site.yml file aan zoals te vinden op [github](https://github.com/HoGentTIN/ops-g-07/tree/master/Ansible/ansible/site.yml)
    * Let op dat je enkel de lijnen die gelden op de LAMP-guest, overneemt.
