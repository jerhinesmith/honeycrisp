# honeycrisp [![Build Status](https://travis-ci.org/jerhinesmith/honeycrisp.svg?branch=master)](https://travis-ci.org/jerhinesmith/honeycrisp)

A module for validating receipts with Apple's App Store. [Click here to read the full documentation.][documentation]

## Installation

To install using [Bundler][bundler] grab the latest stable version:

```ruby
gem 'honeycrisp', '~> 0.0.1'
```

To manually install `honeycrisp` via [Rubygems][rubygems] simply gem install:

```bash
gem install honeycrisp
```

To build and install the development branch yourself from the latest source:

```bash
git clone git@github.com:jerhinesmith/honeycrisp.git
cd honeycrisp
make install
```

## Getting Started With Honeycrisp

### Setup Work

``` ruby
require 'rubygems' # not necessary with ruby 1.9 but included for completeness
require 'honeycrisp'

# put your own credentials here
shared_secret = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'

# set up a client to talk to the App Store
@client = Honeycrisp::Client.new shared_secret, use_sandbox: true

# alternatively, you can preconfigure the client like so
Honeycrisp.configure do |config|
  config.shared_secret = shared_secret
  config.use_sandbox = true
end

# and then you can create a new client without parameters
@client = Honeycrisp::Client.new
```

### Validate a receipt

``` ruby
receipt = @client.validate_receipt(base64_encoded_string)
```

## Supported Ruby Versions

This library supports has been manually tested agains the following Ruby
implementations:

- Ruby 2.1.0

## More Information

[bundler]: http://bundler.io
[rubygems]: http://rubygems.org
[gem]: https://rubygems.org/gems/honeycrisp
[documentation]: https://developer.apple.com/library/ios/releasenotes/General/ValidateAppStoreReceipt/Chapters/ValidateRemotely.html#//apple_ref/doc/uid/TP40010573-CH104-SW1
