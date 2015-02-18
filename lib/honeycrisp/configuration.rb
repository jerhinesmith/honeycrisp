module Honeycrisp
  module Configuration
    attr_accessor :shared_secret, :use_sandbox

    def configure
      yield self
    end

    def self.extended(base)
      base.set_default_configuration
    end

    def set_default_configuration
      self.shared_secret  = ''
      self.use_sandbox    = true
    end
  end
end
