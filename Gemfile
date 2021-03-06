source 'https://rubygems.org'

ruby '2.1.4'
gem 'rails', '4.2'
gem 'sass-rails', github: 'rails/sass-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'spring',        group: :development
gem 'haml-rails'
gem 'pg'

gem 'devise'

gem 'mechanize'
gem 'httparty'
gem "active_model_serializers", github: 'rails-api/active_model_serializers', branch: '0-8-stable'
gem 'whenever', :require => false

gem 'twilio-ruby', '~> 3.12'
gem 'bitly'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_21]
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'html2haml'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
  gem "letter_opener"
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv', github: "capistrano/rbenv"

end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'rspec-rails'
end
group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'faker'
  gem 'launchy'
  gem 'selenium-webdriver'
end

group :produciton do
  gem 'unicorn'
end

gem 'bitters'

source 'https://rails-assets.org' do
  # Bower based assets files
  gem 'rails-assets-angular'
  gem 'rails-assets-angular-ui-router'
  gem 'rails-assets-lodash'
  gem 'rails-assets-restangular'
  gem 'rails-assets-angucomplete-alt'

  # gem 'rails-assets-angucomplete-alt'
  #
  gem 'rails-assets-normalize-css'
  gem 'rails-assets-bourbon'
  gem 'rails-assets-neat'
  gem 'rails-assets-font-awesome'
end
