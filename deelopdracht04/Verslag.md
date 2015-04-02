# Verslag deelopdracht 4: Disaster recovery

##Inleiding
Bij de aanvang van de groepssessie kregen we een briefing van de docent waarin meegedeeld werd dat ons bedrijf alles had verloren (inclusief backups, privé laptops, etc).
Onze opdracht luidde als volgt: Zet alle servers terug op binnen de 5 uur gebruik makend van de de lokale PCs en de documentatie beschikbaar op GitHub.
Aangezien we met 3 personen aanwezig waren hebben we besloten om elk een server op te zetten. Robbe zette de Java EE op, Hans de WISA en Natasha de LAMP.

## WISA
### Conclusie WISA
## Java EE
### Conclusie Java EE
## LAMP
Om de LAMP op te zetten ging ik als volgt te werk: de github repository werd erbij gehaald, in specifiek het stappenplan van LAMP en de box die standaard op de server beschikbaar is.
Aangezien de opdracht van deelopdracht 2 in hield dat we de serves geautomatiseerd moesten opzetten was het stappenplan daar ook naar gemaakt.
De box verkrijgen en toevoegen aan virtual box bleek geen probleem te zijn. Echter bij het opstarten van de box via vagrant liep het mis. Het lukte niet om Ansible aan de praat te krijgen.
![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht04/screenshots/lamp_ansible_error.jpg "Ansible error")  
Dit zou te verhelpen zijn door Ansible te installeren op de lokale PCs, maar aangezien we de rechten niet kregen was dit niet mogelijk. Om Ansible toch maar aan de praat te krijgen heb ik nog vele opgezocht en zaken uitgeprobeerd maar telkens viel ik op hetzelfde probleem: geen sudo rechten.
Een idee was om het te proberen op windows server i.p.v Fedora, maar op windows server draait virtual box niet dus dit was ook uitgesloten.
Het idee was om het toch maar geautomatiseerd op te zetten. Na wat tijd te verspillen heb ik dan uiteindelijk toch beslist om de lamp stack manueel op te zetten.
Het manueel opzetten verliep wel vlot waardoor het opzetten van de lamp binnen de 5u nog gelukt is. Om exact 16u is de lamp stack opgezet, de server draaide, WordPress was geïnstalleerd en werkte. De totale duur van het opzetten was minder dan 4u.
### Conclusie LAMP
Na afloop van de opdracht was het duidelijk dat het stappenplan van lamp niet voldeed aan de verwachtingen. Het stappenplan is namelijk zo opgesteld dat alle prerequisist voldaan zijn. In dit geval was 1 van de prerequisist niets voldaan; Ansible was niet geïnstalleerd. De les die we hieruit geleerd hebben is dat we er niet van uit mogen gaan at alle prerequists voldaan zijn en dit moeten we opnemen in het stappenplan. Het stappenplan hebben we nu zo aangepast dat de lamp stack opgesteld kan worden zonder Ansible.
In totaal heeft het opzetten van de lamp stack minder dan 4u geduurd. Door te fixeren op Ansible werkende te krijgen en te troubleshooten is de tijd zo hoog opgelopen. Het vastklampen aan het stappenplan dat niet voldeed (achteraf gezien) was een slecht idee. Het beste had geweest om van in het begin de lamp stack manueel op te zetten, hierdoor zouden we de tijd terug gedrongen kunnen hebben met 3 uur. Waardoor we maximaal 1 uur aan het opzetten zouden gewerkt hebben.
Het stappenplan is aangepast en de lessen zijn geleerd.
