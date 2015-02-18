module Honeycrisp
  class InAppPurchase
    attr_accessor :quantity, :product_id, :transaction_id, :original_transaction_id,
                  :purchase_date_ms, :original_purchase_date_ms, :is_trial_period

    def initialize(attributes = {})
      attributes.each do |k, v|
        send("#{k}=", v) if respond_to?("#{k}=".to_sym)
      end

      # Return self
      self
    end

    def purchase_date
      Time.at(purchase_date_ms.to_i / 1000).utc
    end

    def original_purchase_date
      Time.at(original_purchase_date_ms.to_i / 1000).utc
    end
  end
end
