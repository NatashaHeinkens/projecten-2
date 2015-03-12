---
title: Deelopdracht Project II Systeembeheer
subtitle: PrBach TI, 2014-2015
lang: dutch
documentclass: scrartcl
...

# Opdracht 1: Planning IP adressering

## Opdrachtomschrijving

(1) Bij een klant hebben we het probleem dat de documentatie ivm IP-adressering onzorgvuldig bijgehouden was. Van een bepaalde host is enkel deze info nog beschikbaar:

- Subnetmasker: 255.255.255.240
- Hoofdnetwerk: 196.83.116.0
- Het is de 5e host in het 9e subnet binnen dat hoofdnetwerk

We willen onze documentatie vervolledigen en hebben daarom onderstaande gegevens nodig. Reconstrueer deze aan de hand van de overgebleven informatie.

- IP-adres van deze host
- IP-adres van het subnet
- Broadcastadres van dat subnet
- Eerste machine van dat subnet
- Laatste machine van dat subnet
- Klasse van het hoofdnetwerk (A, B,...)
- Aantal bruikbare subnetten in het hoofdnetwerk
- Aantal bruikbare hostadressen in elk subnet

(2) We moeten voor een andere klant het netwerk opnieuw inrichten. De geplande opstelling ziet er zo uit:

![Structuur klantnetwerk](img/opdracht01-opstelling.png)

Hieronder volgt een oplijsting van het aantal hosts dat we per departement moeten voorzien, incl. enkele seriële verbindingen. We gaan VLSM toepassen om het netwerk efficiënt onder te verdelen in hiërarchische subnetten. Het "nulde subnet" is bruikbaar.

- Departement Administratie: 20 hosts
- Departement Directie: 10 hosts
- Departement Personeel: 500 hosts
- 2 seriële verbindingen


### Deliverables

Dien een rapport in met:

1. Alle informatie ivm de host van de eerste deeltaak
2. Voor het te plannen netwerk:
    - Opgave van het totaal aantal te voorziene hosts
    - (Gemotiveerde) keuze van het meest geschikte netwerkadres:
        - 192.168.1.0/24
        - 172.16.0.0/16
        - 10.0.0.0/8
    - Gedetailleerde onderverdeling in subnetten volgens VLSM:

| Nr.  | Naam | Netwerkadr. | Subnetmask | CIDR- | 1e hostadr. | Laatste hostadr. | Broadcastadr. |
| :--- | :--- | :---        | :---       | :---  | :---        | :---             | :---          |
| 0    |      |             |            |       |             |                  |               |
| 1    |      |             |            |       |             |                  |               |
| 2    |      |             |            |       |             |                  |               |
| 3    |      |             |            |       |             |                  |               |
| 4    |      |             |            |       |             |                  |               |

### Aanvullende info

1. CCNA 1, "[Introduction to Networks](https://tinfbo2.hogent.be/ccna/1/)", hst 2, 8, 9
    - Te kennen leerstof, verwerken in zelfstudie!
2. Didier Vandenbroucke, Oefenautomaat Subnetting, [http://www.brouckie.be/cgi-bin/IPsubnetting/index.pl](http://www.brouckie.be/cgi-bin/IPsubnetting/index.pl)
