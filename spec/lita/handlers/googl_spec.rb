require "spec_helper"

describe Lita::Handlers::Googl, lita_handler: true do

  it { is_expected.to route_command("googl http://google.com").to(:googl) }

  it "should do nothing on invalid request" do
    send_command("googl ")
    expect(replies.last).to be_nil
  end

  let(:shorten) { instance_double("::Googl::Shorten") }
  let(:expand) { instance_double("::Googl::Expand") }

  before do
    registry.config.handlers.googl do |config|
      config.api_key = "APIKEY"
      config.ip = "0.0.0.0"
    end

    allow(::Googl::Shorten).to receive(:new).and_return(shorten)
    allow(::Googl::Expand).to receive(:new).and_return(expand)
  end

  it "should send shorten request" do
    long_url = 'http://zaralab.org/'
    short_url = 'http://goo.gl/x5PsTf'

    short = ::Googl::Shorten.new
    allow(short).to receive(:short_url).and_return(short_url)
    allow(short).to receive(:long_url).and_return(long_url)

    allow(::Googl).to receive(:shorten).with(
      long_url,
      registry.config.handlers.googl.api_key,
      registry.config.handlers.googl.ip,
    ).and_return(shorten)

    user1 = Lita::User.create(123, name: "user1", mention_name: 'user1')
    send_command("googl #{long_url}", as: user1)
    expect(replies.last).to eq("#{user1.name} #{short_url}")
  end
end
