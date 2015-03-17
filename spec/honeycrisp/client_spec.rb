require 'spec_helper'

describe Honeycrisp::Client do
  describe 'config at class level' do
    after(:each) do
      Honeycrisp.set_default_configuration
    end

    it 'should set the shared secret and sandbox setting with a config block' do
      Honeycrisp.configure do |config|
        config.shared_secret = 'someSecret'
        config.use_sandbox   = true
      end

      client = Honeycrisp::Client.new
      expect(client.shared_secret).to eq('someSecret')
      expect(client.use_sandbox).to eq(true)
    end

    it 'should overwrite shared secret and sandbox setting if passed to initializer' do
      Honeycrisp.configure do |config|
        config.shared_secret = 'someSecret'
        config.use_sandbox   = true
      end

      client = Honeycrisp::Client.new 'anotherSecret', use_sandbox: false
      expect(client.shared_secret).to eq('anotherSecret')
      expect(client.use_sandbox).to eq(false)
    end

    it 'should overwrite the shared secret if only the secret is given' do
      Honeycrisp.configure do |config|
        config.shared_secret = 'someSecret'
        config.use_sandbox   = true
      end

      client = Honeycrisp::Client.new 'onlyTheSecret'
      expect(client.shared_secret).to eq('onlyTheSecret')
      expect(client.use_sandbox).to eq(true)
    end

    it 'should allow options after setting up auth with config' do
      Honeycrisp.configure do |config|
        config.shared_secret = 'someSecret'
        config.use_sandbox   = true
      end

      client = Honeycrisp::Client.new use_sandbox: false
      expect(client.use_sandbox).to eq(false)
    end

    it 'should throw an argument error if the shared secret isn\'t set' do
      expect { Honeycrisp::Client.new }.to raise_error(ArgumentError)
    end
  end

  describe 'in sandbox mode' do
    it 'should use the sandbox host' do
      honeycrisp = Honeycrisp::Client.new('someSecret', use_sandbox: true)

      expect(honeycrisp.host).to eq('https://sandbox.itunes.apple.com')
    end
  end

  describe 'in production mode' do
    it 'should use the production host' do
      honeycrisp = Honeycrisp::Client.new('someSecret', use_sandbox: false)

      expect(honeycrisp.host).to eq('https://buy.itunes.apple.com')
    end
  end

  describe 'validating a receipt' do
    before do
      @client = Honeycrisp::Client.new('someSecret')
    end

    it 'queries Apple for a receipt' do
      receipt = @client.validate_receipt('cafebabe')

      expect(receipt).to be_an_instance_of(Honeycrisp::Receipt)
    end
  end
end
