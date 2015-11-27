# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruboty/twitter_direct_message/version'

Gem::Specification.new do |spec|
  spec.name          = "ruboty-twitter_direct_message"
  spec.version       = Ruboty::TwitterDirectMessage::VERSION
  spec.authors       = ["gin0606"]
  spec.email         = ["kkgn06@gmail.com"]

  spec.summary       = "An ruboty adapter for twitter DM."
  spec.homepage      = "https://github.com/gin0606/ruboty-twitter_direct_message"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"
  spec.add_dependency "mem"
  spec.add_dependency "ruboty"
  spec.add_dependency "twitter", ">= 5.0.0"
  spec.add_dependency "tweetstream", "~> 2.6.1"
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
