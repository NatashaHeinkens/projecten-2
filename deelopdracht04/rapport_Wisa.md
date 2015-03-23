## Rapport Labo 4: WISA ##

*Uitvoerder: Hans Meuris

### Verloop heropstarten WISA ###

Om te beginnen nam ik het stappenplan van de WISA server (labo 2) en volgde het, na het clonen van de nodige bestanden van onze Github. Van mijn teamleden kreeg ik de url om een basebox te downloaden, maar gezien de grootte van het bestand en de trage downloadtijden begon ik al met het zelf klaarmaken van een nieuwe basebox. Gezien we geen sudo rechten hadden kwam ik in de problemen met het opzetten van Packer, de applicatie die we gebruikten voor het opzetten van onze eigen basebox vanuit een basis VM-image. Na het signaleren van de problemen mochten we een basebox gebruiken vanop de klas-server, ons ter beschikking gesteld door een van de begeleiders, Dhr Bert Van Vreckem. Hierdoor kon ik het deel “Opzetten van vagrantbox” volledig overslaan.

Gezien vagrant al geïnstalleerd was op de klas-PC’s kon ik ook de eerste stap van van het deel “Gebruik van Vagrantbox” overslaan. Hierna was er korte verwarring vermits er bestanden waren hernoemd sinds het opstellen van het stappenplan, maar na korte communicatie met de teamleden was dit vlug uitgeklaard.

Het grootste probleem begon toen ik met het commando “vagrant up” probeerde met vagrant de VM te maken, want ik kreeg meteen een error op de lijn ‘ powershell_args: "-executionpolicy unrestricted" ’. Na lange tijd tevergeefs een oplossing te zoeken besliste ik de lijn uit te commentariëren als test. Na het opnieuw proberen van “vagrant up” werkte vagrant deze keer wel, maar kreeg ik in Virtualbox wel een grafische omgeving met een cmd.exe terwijl het normaal gezien enkel in de achtergrond moest runnen.

Echter, bij de provisioning van de VM liep het ook vast (zie screenshot 1). Provisioning duurt normaal wel lang maar na 10 minuten was er nog geen enkele verandering, en de hele pc begon enorm traag te reageren. Na de provisioning te cancelen en de VM af te sluiten en opnieuw op te starten, beweerde de pc wel dat de provisioning van de VM weldegelijk was gebeurd, terwijl het ergens duidelijk was verkeerd gelopen. Op die moment zou normaal gezien vagrant alle configuraties in orde gebracht moeten hebben en de WISA-server actief gezet hebben, maar bij vlug testen volgens het stappenplan naar het correcte IP te surfen bleek al snel dat de server niet actief was. Ik heb dan de provisioning opnieuw laten starten, maar kreeg hetzelfde probleem.

Ondertussen was er sprake van dat de problemen misschien veroorzaakt waren tussen een mogelijk verschil tussen de linux-versies  van virtualbox en vagrant die ik op de klas-PC gebruikte en de windows-versies die waren gebruikt toen het stappenplan was opgesteld, dus startte ik een andere pc op onder Windows Server 2012 ipv Fedora, terwijl ik mijn vorige pc verder liet proberen met de provisioning in het geval dat er toch iets productiefs uit zou komen.

Na door vloeiend door de eerste stappen te gaan kwam ik voor een ander probleem te staan. Op de Windows Server 2012 stond geen Virtualbox geïnstalleerd maar HyperV, en vagrant herkende HyperV niet automatisch en zocht naar een Virtualbox. Bij het raadplegen van Dhr Bert Van Vreckem kwamen we er op uit dat HyperV opstarten vanuit de command line administrator-rechten nodig had, en vermits we geen administrator-rechten kregen voor de opdracht was het op windows proberen dus een doodlopend spoor.

Op de fedora-machine was ondertussen niets veranderd behalve dat het nog trager ging en nauwelijks reageerde tot de VM gekilled werd. De begeleider zei toen dat onze problemen ook veroorzaakt konden zijn door verouderde versies van Virtualbox en Vagrant, en heeft deze toen laten updaten.

Na deze updates zette ik de lijn code die daarvoor een error gaf weer uit commentaar, vernietigde ik de vorige gemaakte VM en probeerde een nieuwe te laten genereren. Deze keer kwam er geen error, maar al de vorige resultaten bleven hetzelfde. De provisioning liep nog steeds vast en bij het herhalen beweerde de PC dat het al gebeurd was, en de server was nog niet bereikbaar via de host-machine (zie screenshot 2).

Ondertussen had een van de andere teamleden de vagrantfile aangepast met wat ze hoopte een oplossing, maar deze bleek ook niet te werken, alsook niet een .bat file die ik op de VM zelf runde om de configuratie van de server in orde te brengen.

Op dit punt was de tijd voor het labo op, en werd me de opdracht gegeven een gedetailleerd rapport op te stellen met screenshots. Er konden natuurlijk niet retroactief screenshots genomen worden van de outdated versies, en er was ook niet meer genoeg tijd om van vorige opstellingen de errors te reproduceren om ook daar screenshots van te nemen.


### Bijlagen: Screenshots ###
![alt] ( https://github.com/HoGentTIN/ops-g-07/tree/master/deelopdracht04/Lab4_WISA_Error1  “ScreenshotError1")![alt]
( https://github.com/HoGentTIN/ops-g-07/tree/master/deelopdracht04/Lab4_WISA_Error2  “ScreenshotError2”)