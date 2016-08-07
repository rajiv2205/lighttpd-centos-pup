require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'lighttpd::dotconf' do

  let(:title) { 'lighttpd::dotconf' }
  let(:node) { 'rspec.example42.com' }
  let(:facts) { { :arch => 'i386' , :operatingsystem => 'redhat' } }
  let(:params) {
    { 'ensure'       =>  'present',
      'name'         =>  'www.example42.com',
      'source'       =>  'puppet:///modules/site/lighttpd/www.example42.com.conf',
    }
  }

  describe 'Test lighttpd::dotconf' do
    it 'should create a lighttpd::dotconf' do
      should contain_file('Lighttpd_www.example42.com.conf').with_ensure('present')
    end
  end

  describe 'Test lighttpd::dotconf source parameter' do
    it 'should create a lighttpd::dotconf' do
      content = catalogue.resource('file', 'Lighttpd_www.example42.com.conf').send(:parameters)[:source]
      content.should == "puppet:///modules/site/lighttpd/www.example42.com.conf"
    end
  end

end
