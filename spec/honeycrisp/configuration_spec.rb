require 'spec_helper'

describe Honeycrisp::Configuration do
  describe 'basic config assignment' do
    let(:string_value)  { (0...32).map { (97 + rand(26)).chr }.join }
    let(:boolean_value) { [true, false].sample }

    before(:each) do
      Honeycrisp.configure do |config|
        config.shared_secret  = string_value
        config.use_sandbox    = boolean_value
      end
    end

    it { expect(Honeycrisp.shared_secret).to eq string_value }
    it { expect(Honeycrisp.use_sandbox).to eq boolean_value }
  end
end
