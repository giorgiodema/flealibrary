# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# per far funzioanare carrierwave
require 'carrierwave/orm/activerecord'