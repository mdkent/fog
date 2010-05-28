require File.join(File.dirname(__FILE__),'..','..','..','spec_helper')

describe "Fog::Vcloud::Terremark::Ecloud::InternetService", :type => :tmrk_ecloud_model do
  before do
    @mock_ip = @mock_vdc[:public_ips].first
    @mock_service = @mock_ip[:services].first
    @mock_service_uri = URI.parse("#{@base_url}/extensions/internetService/#{@mock_service[:id]}")
  end

  subject { @vcloud.vdcs[0].public_ips[0].internet_services[0] }

  describe :class do
    subject { Fog::Vcloud::Terremark::Ecloud::InternetService }

    it { should have_identity :href }
    it { should have_only_these_attributes [:href, :name, :id, :type, :protocol, :port, :enabled, :description, :public_ip, :timeout, :url_send_string, :http_header] }
  end

  context "with no uri" do

    subject { Fog::Vcloud::Terremark::Ecloud::InternetService.new() }

    its(:href)            { should be_nil }
    its(:identity)        { should be_nil }
    its(:name)            { should be_nil }
    its(:type)            { should be_nil }
    its(:id)              { should be_nil }
    its(:protocol)        { should be_nil }
    its(:port)            { should be_nil }
    its(:enabled)         { should be_nil }
    its(:description)     { should be_nil }
    its(:public_ip)       { should be_nil }
    its(:timeout)         { should be_nil }
    its(:url_send_string) { should be_nil }
    its(:http_header)     { should be_nil }
  end

  context "as a collection member" do
    subject { @vcloud.vdcs[0].public_ips[0].internet_services[0] }
    let(:public_ip) { @vcloud.get_public_ip(@vcloud.vdcs[0].public_ips[0].internet_services[0].public_ip.href).body }

    it { should be_an_instance_of Fog::Vcloud::Terremark::Ecloud::InternetService }

    its(:href)                  { should == @mock_service_uri }
    its(:identity)              { should == @mock_service_uri }
    its(:name)                  { should == @mock_service[:name] }
    its(:id)                    { should == @mock_service[:id] }
    its(:type)                  { should == "application/vnd.tmrk.ecloud.internetService+xml" }
    its(:protocol)              { should == "HTTP" }
    its(:port)                  { should == 80 }
    its(:enabled)               { should == true }
    its(:description)           { should == "Web Servers" }
    its(:public_ip)             { should == public_ip }
    its(:timeout)               { should == 2 }
    its(:url_send_string)       { should == nil }
    its(:http_header)           { should == nil }
  end
end
