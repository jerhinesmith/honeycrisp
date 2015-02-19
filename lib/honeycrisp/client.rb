require 'faraday'
require 'logger'
require 'multi_json'

module Honeycrisp
  class Client
    HTTP_HEADERS = {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json',
      'Accept-Charset' => 'utf-8',
      'User-Agent' => "honeycrisp/#{Honeycrisp::VERSION}" \
                      " (#{RUBY_ENGINE}/#{RUBY_PLATFORM}" \
                      " #{RUBY_VERSION}-p#{RUBY_PATCHLEVEL})"
    }

    attr_reader :shared_secret, :use_sandbox

    def initialize(*args)
      options = args.last.is_a?(Hash) ? args.pop : {}

      @shared_secret  = args[0] || Honeycrisp.shared_secret
      @use_sandbox    = options.fetch(:use_sandbox, Honeycrisp.use_sandbox)

      raise ArgumentError, 'Shared secret is required' if (@shared_secret.nil? || @shared_secret.empty?)
    end

    def host
      use_sandbox ? 'https://sandbox.itunes.apple.com' : 'https://buy.itunes.apple.com'
    end

    def validate_receipt(base64_receipt)
      connection.response :logger, ::Logger.new($stdout) if ENV['HONEYCRISP_DEBUG'] == 'true'

      params = {
        'receipt-data'  => base64_receipt,
        'password'      => shared_secret
      }

      response = connection.post do |request|
        request.url '/verifyReceipt'
        request.headers.merge!(HTTP_HEADERS)
        request.body = MultiJson.dump(params)
      end

      Honeycrisp::Receipt.new(MultiJson.load(response.body))
    end

    private
    def connection
      @connection ||= Faraday.new(url: host) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end
  end
end
