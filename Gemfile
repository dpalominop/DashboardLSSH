source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.1'
## Use sqlite3 as the database for Active Record
#gem 'sqlite3'

# Postgresql
gem 'pg'

# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Devise
gem 'devise'

# ActiveAdmin
gem 'activeadmin', github: 'activeadmin/activeadmin'

# ActiveMaterial
gem "active_material", github: "vigetlabs/active_material"

# ActiveAdmin Addons
gem 'activeadmin_addons', github: 'platanus/activeadmin_addons'

# ActiveAdmin Upload Data
gem "active_admin_import" , github: "activeadmin-plugins/active_admin_import"

# Cancancan
gem 'cancancan', '~> 2.0'

# Graph
gem 'chartkick'

# Agroupar por fecha
gem 'groupdate'

# Hightop
gem 'hightop'

# SSH
gem 'net-ssh'

group :development do
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-passenger'

  # Remove the following if your app does not use Rails
  gem 'capistrano-rails'

  # Remove the following if your server does not use RVM
  gem 'capistrano-rvm'

  # Capistrano Rails DB
  gem 'capistrano-rails-db'

  # Entity-Relationship Diagrams
  gem 'rails-erd', require: false
end

gem "paperclip", git: "git://github.com/thoughtbot/paperclip.git"
# gem "paperclip-storage-ftp"
gem 'paperclip-sftp', git: "git@github.com:spectator/paperclip-sftp.git"

# PDF
gem 'wicked_pdf'

# Obfuscate
gem "acts_as_hashids"
