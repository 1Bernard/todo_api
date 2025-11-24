source "https://rubygems.org"

gem "rails", "~> 8.1.1"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"
gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false

# Core API & Security
gem "bcrypt", "~> 3.1", ">= 3.1.20"
gem "jwt", "~> 3.1", ">= 3.1.2"
gem "rotp", "~> 6.3"
gem "rqrcode", "~> 3.1"
gem "pundit", "~> 2.5", ">= 2.5.2"
gem "acts_as_tenant", "~> 1.0", ">= 1.0.1"
gem "rack-cors", "~> 3.0"
gem "rack-attack", "~> 6.8"

# Serialization & Documentation
gem "jsonapi-serializer", "~> 2.2"
gem "rswag-api", "~> 2.17"
gem "rswag-ui", "~> 2.17"
gem "redis", "~> 5.4", ">= 5.4.1" # For Action Cable & caching

# Stripe Integration
gem 'stripe', '~> 18.0', '>= 18.0.1'
gem 'stripe_event', '~> 2.13'

# File Uploads & Processing
gem "cloudinary", "~> 2.4"
gem 'image_processing', '~> 1.14'

# Data Management
gem 'discard', '~> 1.4'
gem 'paper_trail', '~> 17.0'

# AI & Machine Learning
gem "ruby-openai", "~> 8.3"
gem "langchainrb", "~> 0.19.5"
gem "vectorsearch", "~> 0.1.2"

# PDF Generation
gem "prawn", "~> 2.5"
gem "prawn-table", "~> 0.2.2"

# Search & Analytics
gem "ransack", "~> 4.4", ">= 4.4.1"
gem "ahoy_matey", "~> 5.4", ">= 5.4.1"
gem "groupdate", "~> 6.7"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
  gem "brakeman", require: false
  gem "rspec-rails", "~> 8.0", ">= 8.0.2"
  gem "factory_bot_rails", "~> 6.5", ">= 6.5.1"
  gem "rubocop-rails-omakase", require: false
  gem "faker", "~> 3.5", ">= 3.5.2"
  gem "shoulda-matchers", "~> 7.0", ">= 7.0.1"
  gem "database_cleaner-active_record", "~> 2.2", ">= 2.2.2"
  gem "dotenv-rails", "~> 3.1", ">= 3.1.8"
end

group :test do
  gem "simplecov", "~> 0.22.0"
  gem "webmock", "~> 3.26", ">= 3.26.1"
end

group :development do
  gem "listen", "~> 3.9"
  gem "spring", "~> 4.4"
  gem "spring-watcher-listen", "~> 2.1"
end
