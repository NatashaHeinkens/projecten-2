---
title: Deelopdracht Project II Systeembeheer
subtitle: PrBach TI, 2014-2015
lang: dutch
documentclass: scrartcl
...

# Opdracht 2: Opzetten webservers

## Opdrachtomschrijving

Verschillende klanten vragen ons om hun website te hosten. Tot nu toe hebben we altijd manueel een server opgezet en geïnstalleerd, maar door de groeiende vraag is dit niet houdbaar. De bedoeling is een soort "serversjabloon" uit te werken zodat we veel sneller een server kunnen opzetten, naar de specificaties van de klant. Om het voor een webapplicatie-ontwikkelaar eenvoudiger te maken om op haar/zijn eigen laptop een testomgeving op te zetten, is de eerste stap het creëren van VirtualBox VMs. De bedoeling is wel om servers met **exact dezelfde** configuratie in een productie-omgeving op te zetten (bv. Azure, Digital Ocean, Amazon Web Services, OpenShift, enz.).

We voorzien in eerste instantie de volgende platformen:

- **LAMP stack**: CentOS 7 (minimale installatie) + Apache + MySQL + PHP
- **Java EE stack**: CentOS 7 + Java 1.7 + Tomcat 7
- **WISA stack**: Windows 2012 R2 + IIS 8  + MySQL of SQLServer + ASP.NET

### Acceptatiecriteria

- Het moet voor een applicatie-ontwikkelaar eenvoudig zijn om een webapplicatie op de (virtuele) server te draaien. Via VirtualBox kan je mappen op het hostsysteem op een VM "mounten"
- Het opzetten van deze servers moet **exact reproduceerbaar** zijn.
    - Een gedetailleerde procedure is een minimumvereiste, Dat betekent dat een ander teamlid in staat is om zonder hulp en zonder gebruik te maken van externe bronnen in een minimum aan tijd exact dezelfde server kan opzetten.
    - Dit proces automatiseren is nog beter. Dat kan aan de hand van een script (bv. Bash) of door gebruik te maken van een automatiseringstool zoals [Vagrant](http://vagrantup.com/) en [Ansible](http://ansible.com/)).
- Er is de nodige aandacht besteed aan beveiliging: toegang gebruiker(s) met de juiste permissies, firewall-instellingen, minimale installatie, laatste updates uitgevoerd, enz.
- Zorg er voor dat het eenvoudig is om deze servers, incl. de applicatie, "in productie" te brengen op een cloud-platform, bijvoorbeeld
    - [Digital Ocean](https://www.digitalocean.com/) (via het [Github Student Pack](https://education.github.com/pack) kan je gratis credits krijgen)
    - [OpenShift](https://www.openshift.com/) (er is een gratis basispakket)
    - [Azure](http://azure.microsoft.com/) (je kan als student een [gratis "pass"](http://www.microsoftazurepass.com/azureu) bekomen)

### Deliverables

- VirtualBox VMs voor alle gevraagde platformen
    - Demo-applicatie die aantoont dat de stack werkt, te tonen tijdens de contactmomenten
- Demo van elk platform in een productie-omgeving, te tonen tijdens de contactmomenten
- Testplan en testrapport (op Github)
- Gedetailleerde installatieprocedures of scripts (op Github)
    - Voor de VMs
    - Voor het opzetten van de productie-servers
- Handleiding voor gebruikers (i.e. programmeur die de VM gebruikt om een webapplicatie te ontwikkelen) (op Github)


