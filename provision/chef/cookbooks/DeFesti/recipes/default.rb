user 'defesti' do
  home '/home/defesti'
  group 'ubuntu'
  shell '/bin/bash'
  manage_home true
end


apt_update 'update' do
  action :update
end

package 'mongodb' do
  action :upgrade
end

package 'git' do
  action :upgrade
end

package 'npm' do
  action :upgrade
end

package 'nodejs' do
  action :upgrade
end

directory '/home/defesti/node_modules' do
  owner 'defesti'
end

execute "npm install --prefix /home/defesti/ express"

execute "npm install --prefix /home/defesti/ passport"

execute "npm install --prefix /home/defesti/ mongoose"
