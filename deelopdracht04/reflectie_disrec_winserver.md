###Reflectie Birgitta Croux
Ik was niet aanwezig bij de simulatie disaster recovery. Ons team heeft via Skype gecommuniceerd, zo hebben we samen geprobeerd de problemen met het opzetten van de WISA-stack op te lossen.

Het centrale probleem was dat het opzetten van de stack via Vagrant **niet platformonafhankelijk** was. 
 
**Vagrant** op Linux-hosts communiceert met de VM via SSH, terwijl dat bij Windows-hosts via WinRM gebeurt. Het installatiescript is een Powershell-script. Als mijn opzoekingswerk correct is kan je dit script niet rechtstreeks via SSH runnen omdat een SSH-sessie naar de VM in een terminal emulator terechtkomt en niet in een gewone console. Daarnaast kan je van op een Linuxmachine ook niet zonder het installeren van bijkomende software rdp'en naar een Windows-guest.
Daarom hebben we geprobeerd een .bat-script toe te voegen aan de Vagrantfile, dat enkel cmd.exe zou aanroepen, om dan van daaruit Powershell op te roepen. Ook dat bleek niet te werken op de Linuxmachine in het klaslokaal (op mijn Windowscomputer werkte dit in een vagrant ssh naar de VM wél). 

Ondertussen is er voor een lokale VM en uiterst eenvoudige oplossing: in de Vagrantfile, lijn 22 `v.gui = true` uit commentaar zetten, dan start de VM niet in de achtergrond op maar krijg je een gewoon Virtualboxvenster te zien. Van daaruit kan je dan een Powershellvenster openen en het installatiescript (dat zich in de synced folder C:\vagrant bevindt), laten lopen.  
Deze noodoplossing natuurlijk geen oplossing voor productieservers op Azure.

Het komt me voor dat het werken met **Ansible** eigenlijk het omgekeerde probleem oplevert: wat als je voor de disaster recovery alleen een Windows-host ter beschikking hebt of een Linux-host waar je geen installatierechten op hebt en geen Ansible?  

Dus de kwestie blijft: is er een mogelijkheid om het opzetten van alle stacks te automatiseren die: 
* volledig onafhankelijk is van het host-besturingssysteem én 
* geen enkele installatie van software vereist (Virtualbox dan nog buiten beschouwing gelaten)?

Dit lijkt me zeer onwaarschijnlijk...  
Indien dit niet zo is: moeten we dan niet als laatste toevlucht stappenplannen voor manuele installatie hebben om disaster recovery in alle omstandigheden mogelijk te maken?

