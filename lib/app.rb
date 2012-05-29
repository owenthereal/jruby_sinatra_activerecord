class User < ActiveRecord::Base

end

class Application < Sinatra::Base
  def self.root(*args)
    File.expand_path(File.join(APP_ROOT, *args))
  end

  def self.environment
    APP_ENV.to_sym
  end

  set :environment, Application.environment

  enable :logging, :dump_errors, :raise_errors

  configure :development do
    register Sinatra::Reloader

    Dir[Application.root('lib', '**', '*.rb')].each do |f|
      also_reload f
    end
  end

  not_found do
    logger.error("#{request.request_method} #{request.path} not found")
  end

  error do
    logger.error("Error occurred: #{caller}")
  end

  before do
    #content_type :xml
  end

  get '/users' do
    User.all.collect { |u| u.email }
  end
end
