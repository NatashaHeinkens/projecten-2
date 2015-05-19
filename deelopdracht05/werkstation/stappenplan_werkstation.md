# Stappenplan opzetten Werkstation

## Prerequisites
  * Windows installatie iso bestand (Windows 8)
  * Virtual box 4.3.26

## Stappenplan

**Stap 1.** Open Virtualbox en maak een nieuwe machine aan. Voer een naam in (naar keuze), type: 'Microsoft Windows' en version: 'Windows 8 (64bit)'.  
Opmerking: Indien het systeem waarop je werkt geen 64 bit is moet je bij version 32 bit selecteren.  
![alt](https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht05/werkstation/screenshots/stap1.jpg "stap1")  

**Stap 2.** Kies de hoeveelheid RAM toe aan uw machine. Indien u niet beschikt over een al de grote hoeveelheid geheugen is het aan te raden om maximun 1024mb te selecteren.
Om de machine iets sneller te laten werken kent u bets een grote hoeveelheid geheugen toe.  
![alt](https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht05/werkstation/screenshots/stap2.jpg "stap2")  

**Stap 3.** Creër een harde schijf.
  * **3.1** Kies de optie 'Create a virtual hard drive now'.  
  ![alt](https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht05/werkstation/screenshots/stap3.1.jpg "stap3.1")  
  * **3.2** Kies de optie 'VDI'  
  ![alt](https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht05/werkstation/screenshots/stap3.2.jpg "stap3.2")  
  * **3.3** Kies de optie 'Dynamically allocated'  
  ![alt](https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht05/werkstation/screenshots/stap3.3.jpg "stap3.3")
  * **3.4** Selecteer de hoeveelheid geheugen u aan de harde schijf van de machine wilt toekennen. In dit geval gebruiken we 160gb.  
  ![alt](https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht05/werkstation/screenshots/stap3.4.jpg "stap3.4")

**Stap 4.** De machine is nu aangemaakt maar zal nog niet kunnen opstarten. Voeg een controller IDE toe waarin de iso van de windows installatie komt.
Rechter muisklik op de machine -> Settings -> Storage -> Controller 'IDE' Add CD/DVD -> selecteer de juiste iso  
![alt](https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht05/werkstation/screenshots/stap4.jpg "stap4")

**Stap 5.** Start de machine op en volg de installatie procedure. Het type installatie dat uitgevoerd moet worden is 'Aangepast', voor de rest moet er niets aangepast worden en kutn u gewoon de installatie verder uitvoeren.  
![alt](https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht05/werkstation/screenshots/stap5.jpg "stap5")
