#
# Cookbook Name:: jhead
# Recipe:: default
#

# execute "install-jhead" do
#   command %Q{
#     curl -O http://www.sentex.net/~mwandel/jhead/jhead-2.87.tar.gz &&
#     tar zxvf jhead-2.87.tar.gz &&
#     mv jhead-2.87.tar.gz /usr/local/jhead &&
#     rm jhead-2.87.tar.gz
#   }
#   not_if { File.directory?('/usr/local/mongodb') }
# end
#   
# execute "add-to-path" do
#   command %Q{
#     echo 'export PATH=$PATH:/usr/local/mongodb/bin' >> /etc/profile
#   }
#   not_if "grep 'export PATH=$PATH:/usr/local/mongodb/bin' /etc/profile"
# end

# package "media-gfx/jhead" do
#   version '2.86'
#   action :install
# end

bash "install_something" do
user "root"
  cwd "/tmp"
  code <<-EOH 
  wget http://www.sentex.net/~mwandel/jhead/jhead-2.87.tar.gz
  tar -zxf jhead-2.87.tar.gz
  cd jhead-2.87
  ./configure
  make
  make install
  EOH
  not_if { File.exist?('/usr/bin/jhead') }
end
