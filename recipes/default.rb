%w/ bucket key_id access_key /.each do |k|
  raise "please set node['alerting_logger']['aws']['#{k}']" unless node['alerting_logger']['aws'][k]
end

package 'awscli' do
  action :install
end

node['alerting_logger']['logs'].each do |rot|
  prerotate_cfg =
    if rot['alert'] && rot['alert']['empty']
      "/bin/bash #{node['alerting_logger']['default_dir']}/bin/alert_on_empty.sh $1"
    else
      ''
    end
  require 'shellwords'
  grepfor = ::Shellwords.escape(rot['grep']||node['alerting_logger']['grep'])
  logrotate_app rot['name'] do
    su 'root root'
    path      rot['path']
    frequency 'hourly'
    options   ['missingok', 'compress', 'delaycompress', 'notifempty', 'copytruncate']
    rotate    12
    prerotate prerotate_cfg
    postrotate ["/bin/bash #{node['alerting_logger']['default_dir']}/bin/upload_log_to_s3.sh $1 #{grepfor}"]
  end
end

directory "#{node['alerting_logger']['default_dir']}/bin" do
  action :create
end

template "#{node['alerting_logger']['default_dir']}/bin/notify.sh" do
  source 'notify.sh'
  owner  'root'
  group  'root'
  mode   '0755'
end

template "#{node['alerting_logger']['default_dir']}/bin/alert_on_empty.sh" do
  source 'alert_on_empty.sh'
  owner  'root'
  group  'root'
  mode   '0755'
end

template "#{node['alerting_logger']['default_dir']}/bin/upload_log_to_s3.sh" do
  source 'upload_log_to_s3.sh.erb'
  owner  'root'
  group  'root'
  mode   '0755'
  variables({
    bucket: node['alerting_logger']['aws']['bucket'],
    aws_key_id: node['alerting_logger']['aws']['key_id'],
    aws_key: node['alerting_logger']['aws']['access_key'],
    aws_region: node['alerting_logger']['aws']['region']
  })
end
