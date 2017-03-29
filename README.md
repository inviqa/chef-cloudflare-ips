# cloudflare-ips
=======
Install http_realip.conf for NGINX
Installs a BASH script to fetch the update IPs from CloudFlare and install them
into a http_realip.conf
Installs a cronjob that periodically runs the BASH script

## USAGE
Example:
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
     "recipe[cloudflare-ips]"
  ]
```