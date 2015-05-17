# Introduction

A Docker image for running a PowerDNS Recursor.  This image is published at <a href="https://registry.hub.docker.com/u/cloudhotspot/pdns-recursor/" target="_blank">cloudhotspot/pdns-recursor</a> on Docker Hub.

## Quick Start

Running with default settings:

```console
$ docker run -p 53:53/udp cloudhotspot/pdns-recursor
```

### Overriding a Single Host-to-IP Mapping
The default settings export the local `/etc/hosts` file of the container.  This is handy as you can add a host-to-ip overrides via the docker command line:

```console
$ docker run -p 53:53/udp --add-host=www.gmail.com:1.1.1.1 cloudhotspot/pdns-recursor
```

The default settings are listed below:

```
allow-from=0.0.0.0/0
local-address=0.0.0.0
export-etc-hosts=yes
```


### Set Runtime Options
You can pass any of the pdns_recursor options to the container (see <a href="https://doc.powerdns.com/md/manpages/pdns_recursor.1/" target="_blank">PowerDNS Recursor manpage</a>).

For example, to disable exporting the local hosts files:
```console
$ docker run -p 53:53/udp cloudhotspot/pdns-recursor --export-etc-hosts=no
```

### Quick and Dirty DNS Server
To export a zone file as authoritative, map a path on your Docker host with the zone file(s) in BIND format (see example below) to your container and use the `--auth-zones` flag:
```console
$ docker run -p 53:53/udp -v /path/to/share:/var/zones cloudhotspot/pdns-recursor --auth-zones=example.com=/var/zones/example.com
```
This creates a quick and dirty DNS server without the usual ceremony.  Here is an example zone file:

```shell
$TTL	86400 ; 24 hours could have been written as 24h or 1d
; $TTL used for all RRs without explicit TTL value
$ORIGIN example.com.
@  1D  IN  SOA ns1.example.com. hostmaster.example.com. (
			      2002022401 ; serial
			      3H ; refresh
			      15 ; retry
			      1w ; expire
			      3h ; minimum
			     )
       IN  NS     ns1.example.com. ; in the domain
       IN  NS     ns2.smokeyjoe.com. ; external to domain
       IN  MX  10 mail.another.com. ; external mail provider
; server host definitions
ns1    IN  A      192.168.0.1  ;name server definition     
www    IN  A      192.168.0.2  ;web server definition
ftp    IN  CNAME  www.example.com.  ;ftp server definition
; non server domain hosts
bill   IN  A      192.168.0.3
fred   IN  A      192.168.0.4
```

