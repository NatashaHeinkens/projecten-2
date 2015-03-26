#Test Rapport Lamp

  * **Stap 1.** De vagrantbox is aangemaakt en toegevoegd aan de box list van vagrant.
  ![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht02/lamp/screenshots/stap1.jpg "stap1")
  * **Stap 2.** Alle configuratie-files zijn aangepast volgens het stappenplan zodat vagrant correct functioneert.  
De vagrantfile: ![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht02/lamp/screenshots/stap 2-1.jpg "stap2-1")  
De inventory_dev: ![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht02/lamp/screenshots/stap 2-2.jpg "stap2-2")  
 De vagrant_hosts.yml![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht02/lamp/screenshots/stap 2-3.jpg "stap2-3")  
 De roles:
     * common/main.yml: ![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht02/lamp/screenshots/stap 2-4-1.jpg "stap2-4-1")  
     * lamp/main.yml: ![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht02/lamp/screenshots/stap 2-4-2.jpg "stap2-4-2")  
 site.yml: ![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht02/lamp/screenshots/stap 2-5.jpg "stap5")  
  * **Stap 3.** Het commando “vagrant up” levert een correct werkende VM op.
 ![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht02/lamp/screenshots/stap 6.jpg "stap6")
  * **stap 4.** Via het commando “vagrant ssh” kan men aan de VM SSH aan in de command line interface.
  ![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht02/lamp/screenshots/stap 7.jpg "stap7")
  * **stap 5.** Op de host-machine heeft men in een webbrowser naar het adres “http://192.168.56.10”, waar de php/sql applicatie zichtbaar en bruikbaar is.
  ![alt] (https://github.com/HoGentTIN/ops-g-07/blob/master/deelopdracht02/lamp/screenshots/stap 8.jpg "stap8")
