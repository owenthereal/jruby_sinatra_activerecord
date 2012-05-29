source "http://rubygems.org"

platforms :mri do
  gem 'thin'
  gem 'pg'
end

platforms :jruby do
  #gem 'torquebox', '>= 2.0.0.beta3'
  #gem 'torquebox-server', '>= 2.0.0.beta3'
  gem 'trinidad'
  gem 'jruby-openssl'
  gem 'activerecord-jdbcpostgresql-adapter'
end

gem 'rake'
gem 'sinatra'
gem 'sinatra-contrib'

gem 'activerecord'
gem 'sinatra-activerecord'

group :development do
  gem 'rspec'
  gem 'rack-test', :require => 'rack/test'
end
