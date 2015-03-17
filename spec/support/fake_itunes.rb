require 'sinatra/base'

class FakeItunes < Sinatra::Base
  post '/verifyReceipt' do
    receipt_response 'in_app'
  end

  private
  def mock_responses
    YAML.load(ERB.new(File.read(File.dirname(__FILE__) + '/../fixtures/mock_apple_responses.yml')).result)['verifyReceipt']
  end

  def receipt_response(receipt_type)
    receipt = mock_responses['receipts'][receipt_type]

    json_response(200, receipt)
  end

  def json_response(response_code, body)
    content_type :json
    status response_code
    MultiJson.dump(body)
  end
end