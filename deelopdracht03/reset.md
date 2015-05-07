Hardwarereset switch:

http://notthenetwork.me/blog/2013/05/28/reset-a-cisco-2960-switch-to-factory-default-settings/

Softwarereset switch en router:

Router
```
enable
erase startup-config
reload
no
```

Switches
```
enable
show flash
##Als vlan.dat voorkomt in de weergave van het flash-geheugen:
delete vlan.dat
##
erase startup-config
reload
```
