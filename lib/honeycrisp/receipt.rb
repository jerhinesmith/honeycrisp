module Honeycrisp
  class Receipt
    # Meta fields
    attr_accessor :status, :environment, :raw

    # Receipt fields
    attr_accessor :receipt_type, :app_item_id, :bundle_id, :application_version,
                  :version_external_identifier, :original_purchase_date_ms,
                  :original_application_version, :latest_receipt

    attr_reader   :in_app_purchases, :subscriptions, :errors

    def initialize(receipt_hash)
      # Initialize the errors array
      @in_app_purchases, @subscriptions = [], []

      # Set the meta-fields
      self.raw            = receipt_hash
      self.status         = receipt_hash['status'].to_i
      self.environment    = receipt_hash['environment']
      self.latest_receipt = receipt_hash['latest_receipt']

      # Set the receipt fields
      receipt       = receipt_hash.fetch('receipt', {})
      subscriptions = receipt_hash.fetch('latest_receipt_info', [])
      purchases     = receipt.fetch('in_app', [])

      receipt.each do |k, v|
        send("#{k}=", v) if respond_to?("#{k}=".to_sym)
      end

      purchases.each do |purchase_hash|
        @in_app_purchases << Honeycrisp::InAppPurchase.new(purchase_hash)
      end

      subscriptions.each do |subscription_hash|
        @subscriptions << Honeycrisp::Subscription.new(subscription_hash)
      end

      @in_app_purchases.sort_by{ |s| s.purchase_date_ms.to_i }
      @subscriptions.sort_by{ |s| s.expires_date_ms.to_i }

      # Return self
      self
    end

    def original_purchase_date
      Time.at(original_purchase_date_ms.to_i / 1000).utc
    end

    def latest_purchase
      @in_app_purchases.last
    end

    def latest_subscription
      @subscriptions.last
    end

    def valid?
      # Clear out any errors so we can revalidate
      @errors = []

      # Check the status
      @errors << Honeycrisp::Itunes::Error.new(self.status) if self.status != 0

      # Valid if errors array is empty
      @errors.length == 0
    end
  end
end
