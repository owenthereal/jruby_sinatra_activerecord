class User < ActiveRecord::Base

end

class Application < Sinatra::Base
  def self.root(*args)
    File.expand_path(File.join(APP_ROOT, *args))
  end

  enable :logging, :dump_errors, :raise_errors

  configure :development do
    register Sinatra::Reloader
  end

  before do
    content_type :xml
  end

  get '/users' do
    User.all.collect { |u| u.email }
    raise
  end

  not_found do
    logger.error("#{request.request_method} #{request.path} not found")
  end
end
