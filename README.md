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

### Example Runtime Options
Disable exporting the local hosts files:
```console
$ docker run -p 53:53/udp cloudhotspot/pdns-recursor --export-etc-hosts=no
```

To export a zone file as authoritative, map a path on your Docker host with the zone file(s) to your container and use the `--auth-zones` flag
```console
$ docker run -p 53:53/udp -v /path/to/share:/var/zones cloudhotspot/pdns-recursor --auth-zones=example.com=/var/zones/example.com
```


