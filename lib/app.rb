class User < ActiveRecord::Base

end

class Application < Sinatra::Base
  def self.root(*args)
    File.expand_path(File.join(APP_ROOT, *args))
  end

  def self.env
    @_env ||= APP_ENV.to_s.downcase.to_sym
  end

  enable :logging, :dump_errors, :raise_errors

  configure :development do
    register Sinatra::Reloader
  end

  get '/users' do
    User.all.collect { |u| u.email }
  end
end
