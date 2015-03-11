#Stappenplan LAMP stack
##Prerequisites
  * Virtualbox
  * ansible
  * vagrant
  * [ansible skeleton](https://github.com/bertvv/ansible-skeleton)
  * [base box](https://www.dropbox.com/s/gmvwuv2rwn8mb4u/centos70-nocm.box?dl=0)
  * [optioneel!] Sublime Text 2 (voor gemakzucht)

##Stappenplan
**Stap 1.** Add de box met minimal Centos7 install aan vagrant in gitbash.
	`vagrant box add [naam] [URL]`
	
(vb: vagrant box add LAMP c:\\Projecten\\LAMP\\centos70-nocm.box)

((Om te kijken als de box weldegelijk is toegevoegd controleer met `vagrant box list`, als hij er tussen staat is alles correct verlopen))

**Stap 2.** De ansible files zijn nu klaar om geconfigureerd te worden.
De volgende files in het mapje "ansible-skeleton" moeten aangepast worden:
  * **vagrantfile**
Hierin moet de naam van de box meegegeven worden op lijn 67 `config.vm.box = '[naam]'`
  (vb:  config.vm.box = 'LAMP')  

  * **inventory_dev** (Enkel voor windows hosts-- te vinden onder het mapje ansible in ansible-skeleton)
Voeg de gekozen naam van de host toe.
(vb: Zelf heb ik de host 'web' genoemd dus komt er in het document enkel 'web' te staan)

  * **vagrant_hosts.yml**
De naam en ip adres wordt hierin meegegeven.
(vb: -name: web
      ip: 192.168.56.10)

  * **Roles definiëren**
Even een woordje uitleg. Hier ben je zelf vrij in. Je kan alles roles zoveel opsplitsen als je wilt en voor elk een mapje maken. Hoe dieper je de roles splitst hoe meer mapjes je hebt. Zelf heb ik maar gekozen om 2 mapjes te maken aangezien het allemaal toch samen hoort bij de 'LAMP stack'.
  1. common/main.yml
In het mapje ansible-skeleton\ansible\roles vind je standaard al het mapje 'common' met daaronder een mapje tasks en als laatste main.yml.
In dit bestandje staat enkel:
   ```
   # roles/common/main.yml
   ---
   - name: Install common packages
     yum: pkg={{item}} state=installed
     with_items:
       - libselinux-python
   ```
   Dit wordt dan geinstalleerd en heb je nodig om met ansible templates te kunnen werken. (Staat vermeld p de website van       ansible onder documentation)
   De keuze is echter aan de systeembeheerder om hier iets extra in op te nemen. Ik heb de keuze genomen om een aparte map te    maken waar alles voor de lamp in terecht komt.

  1. lamp/main.yml
   Navigeer terug naar ansible-skeleton\ansible\roles en maak een extra map 'lamp' aan. Hierin maak je een .yml bestand      (copy/paste main.yml bestand van vorige file)
   In deze main.yml (Let er op dat de .yml file "main" heet) voeg je alle instellingen toe die de lamp nodig heeft.
   ```
   # roles/lamp/main.yml
   ---
   - name: Install web
     yum: pkg={{item}} state=installed
     with_items:
       - httpd
       - php
       - php-xml
       - php-mysql

   - name: Start Apache service
     service: name=httpd state=running enabled=yes

   - name: enable Firewalld
     service: name=firewalld state=started enabled=yes

   - name: Configure firewalld
     firewalld: zone=public service={{item[0]}} state=enabled permanent={{item[1]}}
     with_nested:
       - [ http, https ]
       - [ true, false ]
    ```
   Woordje uitleg:    - install web; apache(httpd), php en mysql worden geinstalled.
	   	   - Start Apache service, om apache te laten draaien
	   	   - De firewall instellingen

   1. **site.yml** (te vinden onder ansible-skeleton\ansible)
   De naam van de host en zijn roles worden hierin vermeld.
   Voeg de naam van de host toe en zijn rollen.
   ```
   # site.yml
   ---
   - hosts: web
     sudo: true
     roles:
       - common
       - lamp
   ```

**Stap 3.** De ansible files zijn nu klaar en dus is alles klaar om de machine op te starten.
`vagrant up`
Dit kan even duren. Je kan Virtualbox open zetten en dan zou je normaal gezien 'web' tussen de VMs zien staan.

**Stap 4.** De machine is up and running. Om te controleren als alles correct is verlopen kunnen we eens kijken als we een SSH verbinding hebben.
 `vagrant SSH`

**Stap 5.** Nog even testen als de server werkt. Open een browser en surf naar het ip-adres van de host. In dit geval is dat: http://192.168.56.10
Als alles correct is verlopen krijg je nu de test pagina van apache zelf te zien.

Succes!

