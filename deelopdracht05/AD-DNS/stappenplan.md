#Stappenplan opstellen Windows-server met Active Directory en DNS als Domaincontroller

##Prerequisites
  * Werkende server (fysiek of virtueel) met Windows Server 2012 inclusief alle laaste updates

##Stappenplan

**1.** Start de server op.  
**2.** Ga naar serverbeheer (start normaal automatisch on-boot, maar zo niet: start menu - server manager).  
**3.** Kies voor "Add roles and features".  
**4.** In het venster "Add roles and features wizard", selecteer 'Active Directory: Domain Services' en 'DNS Server'.  
**5.** Klik op Next en laat de server de rollen installeren.  
**6.** Terug in serverbeheer, ga naar de AD settings.  
**7.** Maak een nieuw forest aan, met de juiste naam voor het bedrijf.  
**8.**
