# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'menu-rails/version'

Gem::Specification.new do |spec|
  spec.name          = "menu-rails"
  spec.version       = MenuRails::VERSION
  spec.authors       = ["Fire-Dragon-DoL"]
  spec.email         = ["francesco.belladonna@gmail.com"]
  spec.description   = %q{This gem provide a set of helpers and methods that allow to easily generate a menu and identify the currently active link item}
  spec.summary       = %q{Gem that helps creating menu in views and setting the currently active link item}
  spec.homepage      = "https://github.com/Fire-Dragon-DoL/menu-rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "i18n",                   "~> 0.6.5"
  spec.add_dependency "rails",                  "~> 4.0.0"
  spec.add_dependency "activesupport",          "~> 4.0.0"
  spec.add_dependency "activerecord-tableless", "~> 1.3.3"

  spec.add_development_dependency "bundler",          "~> 1.3"
  spec.add_development_dependency "rspec",            "~> 2.14.0"
  spec.add_development_dependency "combustion",       "~> 0.5.1"
  spec.add_development_dependency "faker",            "~> 1.2.0"
  spec.add_development_dependency "capybara",         "~> 2.2.0"
  spec.add_development_dependency "capybara-webkit",  "~> 1.1.0"
  spec.add_development_dependency "headless",         "~> 1.0.1"
  spec.add_development_dependency "factory_girl",     "~> 4.3.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake"
end
