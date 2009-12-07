#
# Cookbook Name:: flare
# Recipe:: default
# 

if ['solo', 'app', 'app_master'].include?(node[:instance_role])
 
  # be sure to replace "app_name" with the name of your application.
  run_for_app("fave") do |app_name, data|
  
    worker_name = "flare-solr"
    
    # The symlink is created in /data/app_name/current/tmp/pids -> /data/app_name/shared/pids, but shared/pids doesn't seem to be?
    directory "/data/#{app_name}/shared/pids" do
      owner node[:owner_name]
      group node[:owner_name]
      mode 0755
    end
 
    template "/etc/monit.d/solr.#{app_name}.monitrc" do
      source "solr.monitrc.erb"
      #owner node[:owner_name]
      #group node[:owner_name]
      owner "root"
      group "root"
      mode 0644
      variables({
        :app_name => app_name,
        :user => node[:owner_name],
        :worker_name => worker_name,
        :framework_env => node[:environment][:framework_env]
      })
    end
    
    bash "monit-reload-restart" do
       user "root"
       code "pkill -9 monit && monit"
    end 
  end
end