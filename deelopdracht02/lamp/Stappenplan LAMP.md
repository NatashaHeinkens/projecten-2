#Stappenplan LAMP stack
##Prerequisites
  * Virtualbox
  * ansible
  * vagrant
  * [ansible skeleton](https://github.com/bertvv/ansible-skeleton)
  * [base box](https://www.dropbox.com/s/gmvwuv2rwn8mb4u/centos70-nocm.box?dl=0)
  * [mapje PhpTest](https://github.com/HoGentTIN/ops-g-07/tree/master/Ansible/PhpTest)
  * [optioneel!] Sublime Text 2 (voor gemakzucht)

##Stappenplan
**Stap 1.** Add de box met minimal Centos7 install aan vagrant in gitbash.
	`vagrant box add [naam] [URL]`  
	(vb: vagrant box add LAMP c:\\\\Projecten\\\\LAMP\\\\centos70-nocm.box)  
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
   * common/main.yml
   In het mapje ansible-skeleton\ansible\roles vind je standaard al het mapje 'common' met daaronder een mapje tasks en als     laatste main.yml.
   In dit bestandje staat enkel:
   ```
   # roles/common/main.yml
   ---
   - name: Install common packages
     yum: pkg={{item}} state=installed
     with_items:
       - libselinux-python
   ```
   Dit wordt dan geinstalleerd en heb je nodig om met ansible templates te kunnen werken. (Staat vermeld p de website van   ansible onder documentation)
   De keuze is echter aan de systeembeheerder om hier iets extra in op te nemen. Ik heb de keuze genomen om een aparte map te    maken waar alles voor de lamp in terecht komt.

   * lamp/main.yml
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
     
   - name: Configure firewalld
     firewalld: service={{item}} permanent=true state=enabled
     with_items:
       - http
       - https
       
   - name: Install MySQL
     yum: pkg={{item}} state=installed
     with_items:
       - mariadb
       - mariadb-server
       - MySQL-python

   - name: Start MariaDB service
     service: name=mariadb state=running enabled=yes

   - name: Create application database
     mysql_db: name={{ dbname }} state=present

   - name: Create application database user
     mysql_user: name={{ dbuser }} password={{ dbpasswd }}
                   priv=*.*:ALL host='localhost' state=present

   - name: Updates and reboot
     command: {{item}}
     with_items:
       - "sudo yum update"
       - "sudo reboot"
    ```
   Woordje uitleg:  
      install web; apache(httpd), php en mysql worden geinstalled  
      Start Apache service; om apache te laten draaien  
      De firewall instellingen  
      Install MySQL en volgende; installatie en configuratie van MySQL

   * **site.yml** (te vinden onder ansible-skeleton\ansible)
   De naam van de host en zijn roles en variabelen worden hierin vermeld.
   Voeg de naam van de host toe en zijn rollen en variabelen.
   ```
   # site.yml
   ---
   - hosts: web
     vars: 
       dbname: naamTest
       dbuser: userTest
       dbpasswd: passTest
     sudo: true
     roles:
       - common
       - lamp
   ```

**Stap 3.** De ansible files zijn nu klaar en dus is alles klaar om de machine op te starten.
`vagrant up`
Dit kan even duren. Je kan Virtualbox open zetten en dan zou je normaal gezien 'web' tussen de VMs zien staan.

**Stap 4.** De machine is up and running. Om te controleren als alles correct is verlopen kunnen we eens kijken als we een SSH verbinding hebben. (`exit` om de verbinding te verbreken)
 `vagrant SSH`

**Stap 5.** Nog even testen als de server werkt. Open een browser en surf naar het ip-adres van de host. In dit geval is dat: http://192.168.56.10.
Als alles correct is verlopen krijg je nu de test pagina van apache zelf te zien.

Succes!

#Stappenplan LAMP stack- Zonder Ansible

##Prerequisites
  * Virtualbox
  * vagrant
  * [base box](https://www.dropbox.com/s/gmvwuv2rwn8mb4u/centos70-nocm.box?dl=0)

##Stappenplan
**Stap 1.** Add de box met minimal Centos7 install aan vagrant in gitbash.
	`vagrant box add [naam] [URL]`  
	(vb: vagrant box add LAMP c:\\\\Projecten\\\\LAMP\\\\centos70-nocm.box)  
	((Om te kijken als de box weldegelijk is toegevoegd controleer met `vagrant box list`, als hij er tussen staat is alles correct verlopen))  
	
**Stap 2.** Maak een vagrantfile aan met het commando: `vagrant init LAMP`  

**Stap 3.** Start de machine op met het commando: `vagrant up`  

**Stap 4.** De machine is up and running. Om te controleren als alles correct is verlopen kunnen we eens kijken als we een SSH verbinding hebben.(`exit` om de verbinding te verbreken) `vagrant SSH`  

De machine is nu klaar om alles manueel te installeren.  

**Stap 5.** Installeer apache en start de service (in de SSH verbinding).  
  * `sudo yum install httpd`  
  * `sudo systemctl enable httpd.service`: Om de service bij boot te starten.
  * `sudo systemctl start httpd.service`: Om de service te starten.
Om te controleren als dit correct is gebeurd surf in je browser naar de ip adres die je hebt opgegeven in de vegrantfile.  

**Stap 6.** Installeer MariaDB.
  * `sudo yum install mariadb-server mariadb`
  *  `sudo systemctl start mariadb`: Om de service te starten.
  *  `sudo mysql_secure_installation`: Security script om de DB te configureren.  
     * Er wordt gevraagd om een paswoord in de geven. Druk op 'enter'.
     * Druk op 'y' en volg de instructies.
     * Bij de volgende prompts volstaat het om op 'enter' te drukken.
  * `sudo systemctl enable mariadb.service`: Om de service bij boot te starten.

**Stap 7.** Installeer PHP.
  * `sudo yum install php php-mysql`
  * `sudo systemctl restart httpd.service`: Om PHP te doen werken moet de Apache service opnieuw gestart worden.  

**Stap 8.** Configureer de firewall.
  * `sudo firewall-cm --permanent --add-service=http`
  * `sudo firewall-cm --permanent --add-service=https`
  * `sudo systemctl enable firewalld`: Om de service bij boot te starten.
  * `sudo firewall-cm --reload`: zodat de configuratie geladen wordt.
 De machine is nu geconfigureerd en opgesteld. Om dit te testen kunnen we gebruik maken van Wordpress.  

##WordPress installeren- Stappenplan  

**Stap 1.** Creer een MySQL Database en User voor WordPress.  
  * `mysql -u root -p`: Er wordt gevraagd om de paswoord op te geven die je in Stap 6 van de vorige stappenplan hebt opgegeven.
  *  `CREATE DATABASE wordpress;` : Database voor WordPress
  *  `CREATE USER wordpressuser@localhost IDENTIFIED BY 'password';`: 'wordpressuser' en 'password' is in te vullen naar eigen belang. Hiermee heb je een database en een user voor WordPress.
  *  `GRANT ALL PRIVILEGES ON wordpress.* TO wordpressuser@localhost IDENTIFIED BY 'password';` Om de user toegang te geven tot de WordPress database.
  *  `FLUSH PRIVILEGES;`: Om de gewijzigde privileges door te spelen aan MySQL.
  *  `exit`: Om uit MySQL te gaan.   
 
**Stap 2.** Installeer Wordpress.
  * `sudo yum install php-gd` : PHP module die nodig is voor WordPress om images te schalen om thumbnails te maken.
  *  `sudo service httpd restart`: Dit is nodig zodat de nieuwe module wordt gebruikt.
  *  `cd ~ `
     `wget http://wordpress.org/latest.tar.gz` : WordPress downloaden. De download zal een compressed file opleveren.
  * `tar xzvf latest.tar.gz`: Om de download uit te pakken. Dit zal een directory 'Wordpress' opleveren in de home directory.
  * `sudo rsync -avP ~/wordpress/ /var/www/html/`: Dit verplaatst de WordPress files naar Apache's document root. Met het commando `rsync` behouden we de bestandpermissies.
  * `mkdir /var/www/html/wp-content/uploads`: Om een mapje aan te maken waar geuploade files in terecht komen.
  * `sudo chown -R apache:apache /var/www/html/*`: Dit kent de eigenaar en permissies toe aan de WordPress bestanden en mappen.  

**Stap 3.** Configureer WordPress.
  * `cd /var/www/html`: Navigeer naar Apache root directory.
  * `cp wp-config-sample.php wp-config.php`: De main configuratie file die WordPress gebruikt. Hier moeten we zaken in aanpassen.
 Om dit te doen gaan we gebruik maken van de teksteditor 'nano', deze moet nog geinstalleerd worden.
  * `sudo yum install nano`
  * `nano wp-config.php`: Opent de cpnfiguratiefile in nano. Hierin moeten we de parameters veranderen die verwijzen naar de database.
     * Navigeer naar de sectie 'MySQL settings' en verander de velden 'DB_NAME, DB_USER, en DB_PASSWORD' naar de juiste waarden.

**Stap 4.** Vervolledig de installatie.
  * Navigeer in de browser naar de server gebruik makend van de ip van de machine.
  * Vul het formulier in en druk op 'install'  

WordPress is nu klaar om gebruikt te worden.
