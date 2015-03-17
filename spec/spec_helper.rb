require 'bundler'
require 'webmock/rspec'
require 'honeycrisp'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

Bundler.setup

Dir.glob(File.expand_path("../support/**/*.rb", __FILE__), &method(:require))

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each) do
    stub_request(:any, /itunes.apple.com/).to_rack(FakeItunes)
  end
end
