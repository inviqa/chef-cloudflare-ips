# cloudflare-ips
To be used in conjunction with HTTP_AUTH for Nginx when CloudFlare CDN Proxy is
enabled and you need to match the http_auth whitelist against the real IP of the
connecting client that would be otherwise masked by CF's proxy servers IP

* Install http_realip.conf for NGINX
* Installs a BASH script to fetch the update IPs from CloudFlare and install them
into a http_realip.conf
* Installs a cronjob that periodically runs the BASH script

## Requirements
IPv6 addresses are supported starting from versions 1.3.0 and 1.2.1 (Nginx version)

## Example of use
```
"default_attributes": {
  "nginx": {
    "shared_config": {
      "load-balancer": {
           ...
           "includes": ["http_realip.conf"]
         }
       }
     }
   },
   "run_list": [
     ...
     "recipe[cloudflare-ips::nginx-realip]"
  ]
```
