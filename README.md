# CDN.io 

CDN.io is there to always give you get the latest version of hosted JavaScript libraries on public CDNs, programatically.

## Why could this be useful?

I.e., to be used in template generators. In that way we can always rest assured that the user will get the latest version of their CDNed library and we don't have to worry about updating helpers anymore.

## Why did I even bother?

Because CDN services don't offer an API to access their list of hosted libraries!




## Installation

Add this line to your application's Gemfile:

    gem 'cdnio'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cdnio

## Usage

### As a library

```
require 'cdnio'

cdn = CDNio::CDN.new

# Get all instances of jquery in any provider
cdn.latest(:jquery)

# ...only from google!
cdn.latest(:jquery, :google)

# And a list from all providers and all libraries?
cdn.libraries

# But I just wanted Cdnjs! Noo problem :)
cdn.libraries(:cdnjs)
```

### As a Web Service

Go to ```http://cdnio.uxtemple.com``` for the full API description.

I'll update this later on.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## TODO

* Test Test Test!
* Find a stable place to host it? Volunteers? :D
* If some of them actually has an API, use that instead of Nokogiri's scrapping.
* Implement Microsoft's CDN.
* Look for and implement other CDNs?
* Add funky selectors such as \*.
* Add the ability to get more than one library at a time.
* Add the ability to choose a bunch of providers too.
* Refresh providers after a while?
