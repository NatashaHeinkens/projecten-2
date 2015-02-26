1. Het stappenplan volgen levert een werkende VM op, en via VirtualBox kan je mappen op het hostsysteem op een VM “mounten”. 
Het stappenplan is exact reproduceerbaar.

2. Het opzetten van een VM is geautomatiseerd.

3. De gebruikers hebben de juiste permissies. (met minimale gebruikerspermissies)

4. De firewall instellingen zijn optimaal. 
  Windows firewall:
  - Turn on Windows Firewall; aangevinkt(zowel bij 'Home or private network' en 'public location network')
  - Notify me when Windows Firewall blocks a new program; aangevinkt (zowel bij 'Home or private network' en 'public location network')
  - (*) alle benodigdheden ivm iis, asp.net, sql server zijn toegevoegd aan inbound rules (normaal gezien door windows zelf al rules aan toegevoegd)
  Windows defender
  - nog aan te vullen

5. De VM heeft de minimale installatie; windows server 2012, iis8, sql server, asp.net

6. De laatste updates zijn uitgevoerd.

7. Beveiliging: IIS; alle poorten behalve poort 80 blokkeren voor anonieme gebruikers.
IIS; niet gebruikte default accounts verwijderen.

8. Beveiliging: SQL; ook de default accounts.

9. De VM is produceerbaar op een cloud-platform.
