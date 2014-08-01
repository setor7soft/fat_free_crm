source 'https://rubygems.org'

# Uncomment the database that you have configured in config/database.yml
# ----------------------------------------------------------------------
# gem 'mysql2'
# gem 'sqlite3'
 gem 'pg'

# Removes a gem dependency
def remove(name)
  @dependencies.reject! {|d| d.name == name }
end

# Replaces an existing gem dependency (e.g. from gemspec) with an alternate source.
def gem(name, *args)
  remove(name)
  super
end

# Bundler no longer treats runtime dependencies as base dependencies.
# The following code restores this behaviour.
# (See https://github.com/carlhuda/bundler/issues/1041)
spec = Bundler.load_gemspec( File.expand_path("../fat_free_crm.gemspec", __FILE__) )
spec.runtime_dependencies.each do |dep|
  gem dep.name, *(dep.requirement.as_list)
end

# Remove premailer auto-require
gem 'premailer', :require => false

# Remove fat_free_crm dependency, to stop it from being auto-required too early.
remove 'fat_free_crm'

group :development do
  # don't load these gems in travis
  unless ENV["CI"]
    gem 'thin'
    gem 'quiet_assets'
    gem 'capistrano', '~> 2.15'
    gem 'capistrano_colors'
    gem 'guard'
    gem 'guard-rspec'
    gem 'guard-rails'
    gem 'rb-inotify', :require => false
    gem 'rb-fsevent', :require => false
    gem 'rb-fchange', :require => false
  end
end

group :development, :test do
  gem 'rspec-rails', '~> 2'
  gem 'headless'
  #gem 'debugger' unless ENV["CI"]
  gem 'pry-rails' unless ENV["CI"]
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
  gem "acts_as_fu"
  gem 'factory_girl_rails'
  gem 'zeus' unless ENV["CI"]
  gem 'coveralls', :require => false
  gem 'timecop'
end

group :heroku do
  gem 'unicorn', :platform => :ruby
  gem 'rails_12factor'
end

gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'
gem 'execjs'
gem 'therubyracer', :platform => :ruby unless ENV["CI"]
gem 'rails3-jquery-autocomplete', github: 'crowdint/rails3-jquery-autocomplete'
gem 'prototype-rails', github: 'rails/prototype-rails'

gem "ransack", github: "activerecord-hackery/ransack", branch: "rails-4"

# this is because we're not using Strong Parameters right now.
gem "protected_attributes"

# this is because observers are deprecated
gem "rails-observers"

gem 'ransack_ui', github: 'welitonfreitas/ransack_ui'
gem 'ransack',             '~> 1.1.0' # not compatible with 1.2.X yet
gem "zeus"
#gem 'ffcrm_merge', :github => 'fatfreecrm/ffcrm_merge'
gem 'acts_as_paranoid', :github => "byroot/rails3_acts_as_paranoid",  :branch => "rails4.0"

group :development do
  gem "better_errors"
  gem 'meta_request'
  gem 'binding_of_caller'
  gem 'capistrano-unicorn', :require => false
  gem 'rvm-capistrano'
end

gem 'remotipart', '~> 1.2'
#gem 'datashift'
gem 'datashift', github: 'digitalm/datashift', branch: 'init4cRubyProto'
gem 'seed_dump'
