##Owncloud https (verbinding met owncloudserver via SSL)

###1. Self-signed certificate aanmaken op de owncloud-VM

We werken voor test- en demonstratiedoeleinden met een self-signed certificate.

1. Maak een SSH-verbinding met de server. Je hebt hiervoor l/p nodig die je bij installatie/aanmaken via Bitnami Launchpad hebt gekregen
   * Voor lokale stack: default is bitnami/bitnami, de eerste keer dat je de machine opstart in VirtualBox vraagt de machine je dit te veranderen. Vanaf het moment dat je dit gedaan hebt moet je natuurlijk dit paswoord gebruiken.
   * Voor Azure-VM: default login is bitnami1, het paswoord is automatisch gegenereerd toen je de VM lanceerde (zie [owncloud_installatie.md] (/deelopdracht05/owncloud/owncloud_installatie.md)
2. Maak een private key aan:  
   `sudo /opt/bitnami/common/bin/openssl genrsa -out /opt/bitnami/apache2/conf/server.key 2048`
3. Genereer een Certificate Signing Request o.b.v. deze private key:  
   `sudo /opt/bitnami/common/bin/openssl req -new -key /opt/bitnami/apache2/conf/server.key -out /opt/bitnami/apache2/conf/cert.csr`
4. Geef alle informatie op die je gevraagd wordt. Belangrijkste is de FQDN van de server.  Bijvoorbeeld: ops007.cloudapp.net (DNS Name van Azure VM) 
5. Onderteken het certificaat:  
   `sudo /opt/bitnami/common/bin/openssl x509 -in /opt/bitnami/apache2/conf/cert.csr -out /opt/bitnami/apache2/conf/server.crt -req -signkey /opt/bitnami/apache2/conf/server.key -days 365`
6. Herstart Apache:
   `sudo /opt/bitnami/ctlscript.sh restart apache`

###2. HTTPS afdwingen

We moeten zorgen dat de webserver de door de gebruiker ingegeven url zo nodig herschrijft naar 'https'.

1. Maak een SSH-verbinding met de server.
2. Open /opt/bitnami/apache2/conf/bitnami/bitnami.conf in een text editor:  
   `sudo nano /opt/bitnami/apache2/conf/bitnami/bitnami.conf`
3. Voeg de herschrijfregels toe in de sectie <VirtualHost _default_:80>  (de 3 regels die beginnen met Rewrite)
   ```
   <VirtualHost _default_:80>
  DocumentRoot "/opt/bitnami/apache2/htdocs"
  RewriteEngine On
  RewriteCond %{HTTPS} !=on
  RewriteRule ^/(.*) https://%{SERVER_NAME}/$1 [R,L]
  ...
   ```
   Zorg dat je alles exact overneemt!
4. Herstart Apache:  
   `sudo /opt/bitnami/ctlscript.sh restart apache`

Referentie: https://wiki.bitnami.com/Components/Apache#How_to_enable_HTTPS_support_with_SSL_certificates
