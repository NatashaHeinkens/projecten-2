# Test Rapport LAMP heropzetten  

##Inleiding
Bij de aanvang van de groepssessie kregen we een briefing van de leerkracht waarin meegedeeld werd dat ons bedrijf alles had verloren (inclusief backups, prive laptops, etc).
Onze opdracht luidde als volgt: Zet alle servers terug op binnen de 5 uur gebruik makend van de de lokale PCs en de documentatie die we op Github hebben geplaatst.
Aangezien we met 3 personen aanwezig waren hebben we besloten om elk een server op te zetten. Robbe zette de Java EE op, Hans de WISA en Natasha de LAMP.

##Uitwerking  
  * De minimale box is van de lokale server gehaald en toegevoegd aan vagrant.  
![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht04/screenshots/box.jpg "box")
  * De box is geinitialiseerd waardoor een vagrantfile voor die box is aangemaakt. `vagrant init LAMP` 
![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht04/screenshots/init.jpg "init")
  * De machine is opgestart via `vagrant up`.  
![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht04/screenshots/up.jpg "up")
  * De SSH verbinding is verkregen.  `vagrant SSH`
![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht04/screenshots/ssh.jpg "ssh")  
<sup>[1]</sup>
  * Apache is geïnstalleerd.
     * `sudo yum install httpd `
     * `sudo systemctl enable httpd.service`
     * `sudo systemctl start httpd.service`
  * MariaDB is geïnstalleerd.
     * `sudo yum install mariadb-server mariadb` 
     * `sudo systemctl start mariadb` 
     * `sudo mysql_secure_installation` 
     * `sudo systemctl enable mariadb.service`
  * PHP is geïnstalleerd.
     * `sudo yum install php php-mysql `
     * `sudo systemctl restart httpd.service`
  * De firewall is geconfigureerd.
     * `sudo firewall-cm --permanent --add-service=http`
     * `sudo firewall-cm --permanent --add-service=https`
     * `sudo systemctl enable firewalld`
     * `sudo firewall-cm --reload`
  * WordPress is geïnstalleerd.  
     * `mysql -u root -p`
     * `CREATE DATABASE wordpress;`
     * `CREATE USER wordpressuser@localhost IDENTIFIED BY 'password';`
     * `GRANT ALL PRIVILEGES ON wordpress.* TO wordpressuser@localhost IDENTIFIED BY 'password';`
     * `FLUSH PRIVILEGES;`
     * `exit`
     * `sudo yum install php-gd`
     * `sudo service httpd restart`
     * `cd ~ wget http://wordpress.org/latest.tar.gz`
     * `tar xzvf latest.tar.gz`
     * `sudo rsync -avP ~/wordpress/ /var/www/html/`
     * `mkdir /var/www/html/wp-content/uploads`
     * `sudo chown -R apache:apache /var/www/html/*`
     * `cd /var/www/html`
     * `cp wp-config-sample.php wp-config.php`
     * `sudo yum install nano`
     * `nano wp-config.php`  

##Opmerking
<sup>[1]</sup> Eens de SSH key verkregen is konden we van start gaan met manueel alle benodigdheden te installeren en te configureren.

##Conclusie
uur; stappenplan herwerkt; manuele installatie
TODO: screenshots
