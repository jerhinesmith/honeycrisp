module Honeycrisp
  class Subscription < InAppPurchase
    attr_accessor :expires_date_ms

    def expires_date
      Time.at(expires_date_ms.to_i / 1000).utc
    end

    def expired?
      Time.now.utc > expires_date
    end
  end
end
