require 'spec_helper'

describe docker_container('registrator') do
  it { should be_running }
end

describe docker_container('registrator') do
  it { should be_running }
end
