cookbook_file "#{node['nginx']['dir']}/http_realip.conf" do
  source 'nginx/http_realip.conf'
  owner  'root'
  group  'root'
  mode   '0644'
  notifies :reload, 'service[nginx]'
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
  command "/usr/local/bin/http_realip_cloudflare #{node['nginx']['dir']}/http_realip.conf > /dev/null 2>&1"
  user    'root'
end
