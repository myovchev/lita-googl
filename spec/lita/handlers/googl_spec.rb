require "spec_helper"

describe Lita::Handlers::Googl, lita_handler: true do

  it { is_expected.to route_command("googl http://google.com").to(:googl) }
  it { is_expected.to route_command("googl expand http://google.com").to(:googl) }

  it "should do nothing on invalid request" do
    send_command("googl ")
    expect(replies.last).to be_nil
  end

  let(:client) { instance_double("::Googl", client: client_login) }
  let(:client_login) { instance_double("::Googl::ClientLogin") }
  let(:shorten) { instance_double("::Googl::Shorten") }
  let(:expand) { instance_double("::Googl::Expand") }

  before do
    registry.config.handlers.googl do |config|
      config.username = "USERNAME"
      config.password = "PASSWORD"
    end

    allow(::Googl::ClientLogin).to receive(:new).and_return(client_login)
    allow(::Googl::Shorten).to receive(:new).and_return(shorten)
    allow(::Googl::Expand).to receive(:new).and_return(expand)
  end

  it "should send shorten request" do
    long_url = 'http://zaralab.org/'
    short_url = 'http://goo.gl/x5PsTf'

    short = ::Googl::Shorten.new
    allow(short).to receive(:short_url).and_return(short_url)
    allow(short).to receive(:long_url).and_return(long_url)

    allow(client_login).to receive(:shorten).with(long_url).and_return(shorten)

    user1 = Lita::User.create(123, name: "user1", mention_name: 'user1')
    send_command("googl #{long_url}", as: user1)
    expect(replies.last).to eq("#{user1.name} #{short_url}")
  end

  it "should send expand request" do
    long_url = 'http://zaralab.org/'
    short_url = 'http://goo.gl/x5PsTf'

    expand = ::Googl::Expand.new
    allow(expand).to receive(:short_url).and_return(short_url)
    allow(expand).to receive(:long_url).and_return(long_url)

    allow(::Googl).to receive(:expand).with(short_url).and_return(expand)

    user1 = Lita::User.create(123, name: "user1", mention_name: 'user1')
    send_command("googl expand #{short_url}", as: user1)
    expect(replies.last).to eq("#{user1.name} #{long_url}")
  end
end
