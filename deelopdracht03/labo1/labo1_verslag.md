#Verslag labo 1

##Deel 1: Toegang tot een Cisco-switch via Serial Console Port
Om de opstelling te maken hebben we gebruik gemaakt van:
  * Een lokale PC 
  * switch
  * Bekabeling (RJ-45, rollover DB-9 to RJ-45)  
  
De switch en de lokale PC zijn aan elkaar geconnecteerd gebruik makend van de rollover(DB-9 to RJ-45) kabel en beide devices zijn opgestart

##Deel 2: Basisinstellingen van de switch weergeven en configureren
Angezien we op de lokale PCs gebruik maken van linux en Tera Term daar niet compatibel mee is hebben we gebruik gemaakt van 'screen'.
Om de cisco console onder linux te verkrijgen geven we het commando `$ screen /dev/ttyS0` in de terminal in linux op.  
![alt](https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht03/labo1/Screenshots/start.jpg "start")  

De versie van de switch is te vekrijgen met het commando `show version` in de cisco console.  
![alt](https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht03/labo1/Screenshots/show_version.jpg "show version")  

Om de klok te weergeven volstaat het om het commando `show clock` uit te voeren.  
Vooraleer men de klok kan aanpassen moet men in de privileged EXEC mode gaan men het commando `enable`. Daarna kan men overgaan tot het configureren:
  * `clock set ?`
  * `clock set [uur] ?`: Het fromaat van het uur is 00:00:00
  * `clock set [uur] [maand-dag]`: Het formaat van maan-dag is Aaa 00
  * `clock set [uur] [maand-dag] [jaar]` : Het formaat van het jaar is YYYY
Om te verifiëren of de klok weldegelijk is ingesteld geeft men het commando `show clock` opnieuw in.
De klok is ingesteld.  
![alt](https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht03/labo1/Screenshots/show_clock.jpg "show clock")

##Deel 3 (optioneel): Toegang tot een Cisco-switch via Mini-USB console cable  

**Dit onderdeel is niet uitvoerbaar aangezien we niet beschikken over een mini-USB console kabel.** 
