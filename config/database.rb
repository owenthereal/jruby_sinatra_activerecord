##
# You can use other adapters like:
#
#   ActiveRecord::Base.configurations[:development] = {
#     :adapter   => 'mysql',
#     :encoding  => 'utf8',
#     :reconnect => true,
#     :database  => 'your_database',
#     :pool      => 5,
#     :username  => 'root',
#     :password  => '',
#     :host      => 'localhost',
#     :socket    => '/tmp/mysql.sock'
#   }
#

db = URI.parse(ENV['DATABASE_URL'] || "postgresql://localhost:5432/#{Application.environment.to_s}")

ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host     => db.host,
  :port     => db.port,
  :username => db.user,
  :password => db.password,
  :database => db.path[1..-1],
  :encoding => 'utf8'
)

#ActiveRecord::Base.configurations[:development] = {
  #:adapter => 'postgresql',
  #:encoding => 'utf8',
  #:database => 'development',
  #:username => 'Owen'
#}

#ActiveRecord::Base.configurations[:production] = {
  #:adapter => 'sqlite3',
  #:database => Application.root('db', "production.db")

#}

#ActiveRecord::Base.configurations[:test] = {
  #:adapter => 'sqlite3',
  #:database => Application.root('db', "test.db")

#}

# Setup our logger
require 'logger'
ActiveRecord::Base.logger = Logger.new(STDOUT)

# Include Active Record class name as root for JSON serialized output.
ActiveRecord::Base.include_root_in_json = false

# Store the full class name (including module namespace) in STI type column.
ActiveRecord::Base.store_full_sti_class = true

# Use ISO 8601 format for JSON serialized times and dates.
ActiveSupport.use_standard_json_time_format = true

# Don't escape HTML entities in JSON, leave that for the #json_escape helper.
# if you're including raw json in an HTML page.
ActiveSupport.escape_html_entities_in_json = false

# Now we can estabilish connection with our db
#ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[Application.environment])
