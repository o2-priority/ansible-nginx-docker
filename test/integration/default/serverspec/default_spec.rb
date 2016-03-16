require 'spec_helper'

nginx_docker_conf_dir = '/data/nginx'

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
  #{nginx_docker_conf_dir}/templates/jenkins-include.conf.ctmpl
  #{nginx_docker_conf_dir}/templates/jenkins-upstream.conf.ctmpl
  #{nginx_docker_conf_dir}/includes/common/jenkins.conf
  #{nginx_docker_conf_dir}/upstreams/jenkins.conf
).each do |f|
  describe file(f) do
    it { should be_file }
  end
end

describe docker_container('nginx') do
  it { should be_running }
end

