class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #per accedere all'app devo fare login, utente non registrato può visitare solo alcune pagine
  before_action :authenticate_user!

  require 'net/http'
  require 'json'

  require "test/unit/assertions"
  include Test::Unit::Assertions

  require 'rubygems'
  require 'selenium-webdriver'
  require 'test/unit'
end
