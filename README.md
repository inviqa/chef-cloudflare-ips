# cloudflare-ips
To be used in conjunction with HTTP_AUTH for Nginx when CloudFlare CDN Proxy is
enabled and you need to match the http_auth whitelist against the real IP of the
connecting client that would be otherwise masked by CF's proxy servers IP

* Install the http_realip_cloudflare_ips.conf file for NGINX
* Installs a BASH script to fetch the update IPs from CloudFlare and install them
into a http_realip_cloudflare_ips.conf
* Installs a cronjob that periodically runs the BASH script

## Requirements

Need to create a separate http_realip.conf file for Nginx where to add the
`real_ip_header` statement, and where you may maintain an independent list of `set_real_ip_from`
This is usually done using the recipe:
```
  "recipe[config-driven-helper::nginx-http-realip]",
```

IPv6 addresses are supported starting from versions 1.3.0 and 1.2.1 (Nginx version)


## Example of use
```
   "run_list": [
     ...
     "recipe[cloudflare-ips::nginx-realip]"
  ]
```
