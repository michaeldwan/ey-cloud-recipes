#
# Cookbook Name:: flare
# Recipe:: default
#

require 'pp'

if ['solo', 'app', 'app_master'].include?(node[:instance_role])

  # be sure to replace "app_name" with the name of your application.
  run_for_app("fave") do |app_name, data|
    template "/etc/monit.d/solr.#{app_name}.monitrc" do
      source "solr.monitrc.erb"
      owner node[:owner_name]
      group node[:owner_name]
      mode 0644
      variables({
        :app_name => app_name,
        :user => node[:owner_name]
      })
    end
  end
end
