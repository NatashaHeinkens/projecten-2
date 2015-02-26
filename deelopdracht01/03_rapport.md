##Rapport Opdracht 1: Planning IP adressering

###Deel 1

* Gegeven: 
	* Subnetmasker: 255.255.255.240
	* Hoofdnetwerk: 196.83.116.0	
	* Het is de 5e host in het 9e subnet binnen dat hoofdnetwerk

* Gevraagd:
	* IP-adres van deze host.
	* IP-adres van het subnet.
	* Broadcastadres van dat subnet.
	* Eerste machine van dat subnet.
	* Laatste machine van dat subnet.
	* Klasse van het hoofdnetwerk (A, B,…).
	* Aantal bruikbare subnetten in het hoofdnetwerk.
	* Aantal bruikbare hostadressen in elk subnet.

* Oplossing:
	* IP-adres van deze host: 196.83.116.133
	* IP-adres van het subnet: 196.83.116.128
	* Broadcastadres van dat subnet: 196.83.116.143
	* Eerste machine van dat subnet: 196.83.116.129
	* Laatste machine van dat subnet: 196.83.116.142
	* Klasse van het hoofdnetwerk: Klasse C netwerk
	* Aantal bruikbare subnetten in het hoofdnetwerk: 16
	* Aantal bruikbare hostadressen in elk subnet: 14

###Deel 2

* Gegeven:
	* We gebruiken VLSM.
	* Het “nulde” subnet is bruikbaar.
	* Departement Administratie: 20 hosts.
	* Departement Directie: 10 hosts.
	* Departement Personeel: 500 hosts.
	* 2 seriële verbindingen.

* Gevraagd:
	* Een gedetailleerde onderverdeling in subnetten volgens VLSM.
	* Een gemotiveerde keuze van het meest geschikte netwerkadres tussen de volgende 3:
		1. 192.168.1.0/24
		2. 172.16.0.0/16
		3. 10.0.0.0/8

* Oplossing:



	* Een gemotiveerde keuze van het meest geschikte netwerkadres:

		* Gezien we in het totaal 530 host-adressen nodig hebben, plus nog de bijhorende netwerkadressen en broadcastadressen van 5 subnetwerken, hebben we iets groter dan een type C nodig wat maar plaats heeft voor 512 adressen in totaal. De logische keuze is dus het tweede adres, namelijk 172.16.0.0/16, een type B adres. Dit is het goedkoopste om te gebruiken en voldoet nog ruimschoots aan onze requirements. Ook is er ook nog voldoende ruimte voor eventuele uitbreidingen in het netwerk.
	
	* De gedetailleerde onderverdeling in subnetten volgens VLSM.

| Nr. | Naam      | Netwerkadres | Subnetmask      | CIDR | 1e hostadres | Laatste hostadres | Broadcastadres |
| :-: | :-------: | :----------: | :-------------: | :--: | :----------: | :---------------: | :------------: | 
|  0  | Personeel | 172.16.0.0   | 255.255.254.0   |  /23 | 172.16.0.1   | 172.16.1.254      | 172.16.1.255   |
|  1  | Admin     | 172.16.2.0   | 255.255.255.224 |  /27 | 172.16.2.1   | 172.16.2.30       | 172.16.2.31    |
|  2  | Directie  | 172.16.2.32  | 255.255.255.240 |  /28 | 172.16.2.33  | 172.16.2.46       | 172.16.2.47    |
|  3  | Serial    | 172.16.2.48  | 255.255.255.252 |  /30 | 172.16.2.49  | 172.16.2.50       | 172.16.2.51    |
|  4  | ToIsp 	  | 172.16.2.52  | 255.255.255.252 |  /30 | 172.16.2.53  | 172.16.2.54       | 172.16.2.55    |
