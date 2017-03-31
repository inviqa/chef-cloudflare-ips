cookbook_file "#{node['nginx']['dir']}/conf.d/http_realip_cloudflare_ips.conf" do
  source 'nginx/http_realip_cloudflare_ips.conf'
  owner  'root'
  group  'root'
  mode   '0644'
end

cookbook_file "/usr/local/bin/http_realip_cloudflare" do
  source 'nginx/http_realip_cloudflare.sh'
  owner  'root'
  group  'root'
  mode   '0750'
end

cron_d 'http_realip_cloudflare' do
  minute  0
  hour    8
  command "/usr/local/bin/http_realip_cloudflare #{node['nginx']['dir']}/conf.d/http_realip_cloudflare_ips.conf > /dev/null 2>&1"
  user    'root'
end

execute "first run of http_realip_cloudflare" do
  command "/usr/local/bin/http_realip_cloudflare #{node['nginx']['dir']}/conf.d/http_realip_cloudflare_ips.conf"
end
