# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_c2c'
  s.version     = '0.0.1'
  s.summary     = 'CtoC extension for Spree.'
  s.description = 'CtoC extension for Spree.'
  s.required_ruby_version = '>= 1.8.7'

  s.author    = 'Masahiro Saito'
  s.email     = 'camelmasa@gmail.com'
  s.homepage  = 'https://github.com/camelmasa/spree_c2c'

  s.files       = `git ls-files`.split("\n")
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 1.2.0'

  s.add_development_dependency 'capybara', '1.0.1'
  s.add_development_dependency 'factory_girl', '~> 2.6.4'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.9'
  s.add_development_dependency 'sqlite3'
end
