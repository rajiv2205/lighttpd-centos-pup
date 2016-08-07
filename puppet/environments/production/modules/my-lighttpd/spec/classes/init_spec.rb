require 'spec_helper'
describe 'lighttpd' do

  context 'with defaults for all parameters' do
    it { should contain_class('lighttpd') }
  end
end
