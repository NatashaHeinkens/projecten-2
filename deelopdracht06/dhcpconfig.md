option domain-name “group007.be”;

option domain-name-servers dhcp.group007.be;

default-lease-time 600;

max-lease-time 7200;

authoritative;

subnet 10.0.2.0 netmask 255.255.255.0 {
    range dynamic-bootp 10.0.2.16 10.0.2.192;
    option broadcast-address 10.0.2.255;
    option routers 10.0.2.1;
}

host dc {
	option host-name “dc.group007.be”;
	hardware ethernet 08:00:27:64:72:61;
	fixed-address 10.0.2.252
}