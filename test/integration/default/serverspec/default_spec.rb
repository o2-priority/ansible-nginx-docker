require 'spec_helper'

nginx_docker_conf_dir = '/data/nginx'
nginx_docker_service_name = 'jenkins-8080'

%W(
  #{nginx_docker_conf_dir}
  #{nginx_docker_conf_dir}/logs
  #{nginx_docker_conf_dir}/conf.d
  #{nginx_docker_conf_dir}/includes
  #{nginx_docker_conf_dir}/servers
  #{nginx_docker_conf_dir}/templates
  #{nginx_docker_conf_dir}/upstreams
).each do |d|
  describe file(d) do
    it { should be_directory }
  end
end

%W(
  #{nginx_docker_conf_dir}/conf.d/services.conf
  #{nginx_docker_conf_dir}/servers/common.conf
  #{nginx_docker_conf_dir}/templates/#{nginx_docker_service_name}-include.conf.ctmpl
  #{nginx_docker_conf_dir}/templates/#{nginx_docker_service_name}-upstream.conf.ctmpl
  #{nginx_docker_conf_dir}/includes/common/#{nginx_docker_service_name}.conf
  #{nginx_docker_conf_dir}/upstreams/#{nginx_docker_service_name}.conf
).each do |f|
  describe file(f) do
    it { should be_file }
  end
end

describe docker_container('nginx') do
  it { should be_running }
end

describe command('curl -s -o /dev/null -w "%{http_code}" http://10.0.2.15/jenkins/') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match '200' }
end
