# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cdnio/version'

Gem::Specification.new do |gem|
  gem.name          = "cdnio"
  gem.version       = CDNio::VERSION
  gem.date          = Date.today.to_s
  gem.authors       = ["Darío Javier Cravero"]
  gem.email         = ["dario@uxtemple.com"]
  gem.description   = %q{CDN.io is there to always give you get the latest version of hosted JavaScript libraries on public CDNs}
  gem.summary       = %q{Latest CDN versions of a JS libraries made easy}
  gem.homepage      = 'https://github.com/dariocravero/cdnio'

  gem.add_dependency('nokogiri')

  gem.files         = `git ls-files`.split($/)
  # gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
