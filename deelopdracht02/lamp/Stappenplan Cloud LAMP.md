#Stappenplan LAMP-stack op cloudserver
##Prerequisites
  * git
  * een [openshift](https://openshift.redhat.com)-account

##Stappen
  1. Ga naar de homepage van openshift
  2. Kies voor "Add application" of "Make first application"
  3. Onder php, kies voor php 5.4
  4. Pas eventueel de pulic url aan
  5. Klik onderaan op "Create application"
  6. Clone de git waarvan je (na ongeveer een minuut wachten) de link voorgeschoteld krijgt, naar je lokale computer
  7. Klik op "Continue to the application overview page"
  8. Klik op "add MySQL 5.5" - dan op "Add cartidge"
  9. Pas in de git-folder onder de gekozen (stap 4) naam de index.php-file aan naar je eigen homepage
  0. Voeg eventueel andere php- of html-bestanden en mappen toe aan de git
  1. Commit en push de wijzingen
  2. Ga naar de eerder gekozen (stap 4) URL en controleer of alles werkt.
