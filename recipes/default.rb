#
# Cookbook Name:: ruby
# Recipe:: default
#
# Copyright 2015, Simone Dall Angelo
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

# Download libyaml source
remote_file "#{Chef::Config[:file_cache_path]}/yaml-#{node["ruby"]["lib_yaml"]}.tar.gz" do
  source "http://pyyaml.org/download/libyaml/yaml-#{node["ruby"]["lib_yaml"]}.tar.gz"
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  not_if 'ruby -v | grep #{node["ruby"]["version"]}'
end

# Extract source
execute 'Extracting yaml' do
  cwd Chef::Config[:file_cache_path]
  command "tar xzf yaml-#{node["ruby"]["lib_yaml"]}.tar.gz"
  creates "#{Chef::Config[:file_cache_path]}/yaml-#{node["ruby"]["lib_yaml"]}"
  not_if 'ruby -v | grep #{node["ruby"]["version"]}'
end

# Compile it
bash "Install yaml-#{node["ruby"]["lib_yaml"]}" do
  user 'root'
  cwd "#{Chef::Config[:file_cache_path]}/yaml-#{node["ruby"]["lib_yaml"]}"
  code <<-END
    ./configure && make && make install
  END
  only_if do ::File.exists?("#{Chef::Config[:file_cache_path]}/yaml-#{node["ruby"]["lib_yaml"]}") end
  not_if 'ruby -v | grep #{node["ruby"]["version"]}'
end

# Download ruby source
remote_file "#{Chef::Config[:file_cache_path]}/ruby-#{node["ruby"]["version"]}.tar.gz" do
  source "http://cache.ruby-lang.org/pub/ruby/2.1/ruby-#{node["ruby"]["version"]}.tar.gz"
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  not_if 'ruby -v | grep #{node["ruby"]["version"]}'
end

# Extract source
execute 'Extracting ruby' do
  cwd Chef::Config[:file_cache_path]
  command "tar xzf ruby-#{node["ruby"]["version"]}.tar.gz"
  creates "#{Chef::Config[:file_cache_path]}/ruby-#{node["ruby"]["version"]}"
  not_if 'ruby -v | grep #{node["ruby"]["version"]}'
end

# Compile it
bash "Install ruby-#{node["ruby"]["version"]}" do
  user 'root'
  cwd "#{Chef::Config[:file_cache_path]}/ruby-#{node["ruby"]["version"]}"
  code <<-END
    ./configure && make && make install
  END
  not_if 'ruby -v | grep #{node["ruby"]["version"]}'
end

# Update gem --system
bash "Update gem --system" do
  user 'root'
  code <<-END
    /usr/local/bin/gem update --system --no-ri --no-rdoc
  END
end

# Install bundler
gem_package "bundler" do
  action :install
  gem_binary '/usr/local/bin/gem'
end
