#############################################################################
#
# Helper functions
#
#############################################################################

def bootstrap_file
  @bootstrap_file ||= File.expand_path("../config/boot.rb", __FILE__)
end

def task_files
  @task_files ||= Dir[File.join(File.expand_path(File.dirname(__FILE__)), "lib", "tasks", "**", "*.rake")]
end

#############################################################################
#
# Standard tasks
#
#############################################################################

task :environment do
  require bootstrap_file
end

desc "Open an irb session preloaded with this app"
task :console do
  sh "irb -r #{bootstrap_file}"
end

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = "./spec/**/*_spec.rb"
  end
  task :default => :spec
rescue Exception ; end

#############################################################################
#
# ActiveRecord tasks
#
#############################################################################

require 'active_record'
require 'fileutils'

namespace :db do
  def config
     @config ||= ActiveRecord::Base.configurations[Application.environment]
  end

  desc "migrate your database"
  task :migrate => :environment do
    ActiveRecord::Migrator.migrate(
      'db/migrate',
      ENV["VERSION"] ? ENV["VERSION"].to_i : nil
    )
  end

  desc "create an ActiveRecord migration in ./db/migrate"
  task :create_migration => :environment do
    name = ENV['NAME']
    abort("no NAME specified. use `rake db:create_migration NAME=create_users`") if !name

    migrations_dir = File.join("db", "migrate")
    version = ENV["VERSION"] || Time.now.utc.strftime("%Y%m%d%H%M%S")
    filename = "#{version}_#{name}.rb"
    migration_name = name.gsub(/_(.)/) { $1.upcase }.gsub(/^(.)/) { $1.upcase }

    FileUtils.mkdir_p(migrations_dir)

    open(File.join(migrations_dir, filename), 'w') do |f|
      f << (<<-EOS).gsub("      ", "")
      class #{migration_name} < ActiveRecord::Migration
        def self.up
        end

        def self.down
        end
      end
      EOS
    end
  end

  desc "Creates the database for current environment"
  task :create => :environment do
    creation_options = {:charset => (config[:charset] || 'utf8'), :collation => (config[:collation] || 'utf8_unicode_ci')}

    ActiveRecord::Base.establish_connection(config.merge(:database => nil))
    ActiveRecord::Base.connection.create_database(config[:database], creation_options)
    ActiveRecord::Base.establish_connection(config)
  end

  desc "Drops the database for current environment"
  task :drop => :environment do
    database_name = ActiveRecord::Base.configurations[Application.environment][:database]
    ActiveRecord::Base.connection.drop_database database_name
  end

  desc "Reset the database for current environment"
  task :reset => ["db:drop", "db:create", "db:migrate"]
end

#############################################################################
#
# Other tasks
#
#############################################################################

task_files.each { |f| load f }
