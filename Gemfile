source 'https://rubygems.org'
ruby '2.2.3'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.0.0.1'

# Use sqlite3 as the database for Active Record
gem 'sqlite3', group: :development

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

gem 'bootstrap-sass','~> 3.1.1'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
gem 'omniauth-github', github: 'intridea/omniauth-github'
gem 'font-awesome-sass'
gem 'administrate'
gem 'bourbon'

gem 'active_model_serializers', '~> 0.8.1'

gem 'prawn'
gem 'prawn-table'
gem 'active_type'

gem 'delayed_job_active_record'
gem 'daemons'
gem 'twilio-ruby', '~> 4.11.1'

group :development, :test do
  gem 'dotenv-rails'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

group :test do
  gem 'shoulda-matchers'
  gem 'webmock'
  gem 'database_cleaner'
end

group(:production) do
  gem 'rails_12factor'
  gem 'pg'
end

group(:development) do 
  gem 'whenever', :require => false
  gem 'pry-rails'
  gem 'web-console'
end
