require 'rails_helper'

RSpec.describe User, type: :model do

  it "Create User" do
    user = User.create(:name => "name", :surname => "surname", :username => "username", :email => "email@test.it", :password => "minimo", :password_confirmation => "minimo", :radius => "30", :cap => "00015")
    expect(User.where(:email => "email@test.it").first).to eq(user)
  end

  it "Validate User" do
    user = User.new(:name => "name", :surname => "surname", :username => "username", :email => "email@test.it", :password => "minimo", :password_confirmation => "minimo", :radius => "30", :cap => "00015")
    expect(user).to be_valid
  end

  it "Invalid name" do
    user = User.new(:surname => "surname", :username => "username", :email => "email@test.it", :password => "minimo", :password_confirmation => "minimo", :radius => "30", :cap => "00015")
    expect(user).not_to be_valid
  end

  it "Invalid surname" do
    user = User.new(:name => "name", :username => "username", :email => "email@test.it", :password => "minimo", :password_confirmation => "minimo", :radius => "30", :cap => "00015")
    expect(user).not_to be_valid
  end

  it "Invalid username" do
    user = User.new(:name => "name", :surname => "surname", :email => "email@test.it", :password => "minimo", :password_confirmation => "minimo", :radius => "30", :cap => "00015")
    expect(user).not_to be_valid
  end

  it "Invalid email" do
    user = User.new(:surname => "surname", :username => "username", :password => "minimo", :password_confirmation => "minimo", :radius => "30", :cap => "00015")
    expect(user).not_to be_valid
  end

  it "Invalid confirmation password" do
    user = User.new(:surname => "surname", :username => "username", :email => "email@test.it", :password => "minimo", :password_confirmation => "minimominimo", :radius => "30", :cap => "00015")
    expect(user).not_to be_valid
  end

  it "Invalid radius" do
    user = User.new(:surname => "surname", :username => "username", :email => "email@test.it", :password => "minimo", :password_confirmation => "minimo", :cap => "00015")
    expect(user).not_to be_valid
  end

  it "Invalid cap" do
    user = User.new(:surname => "surname", :username => "username", :email => "email@test.it", :password => "minimo", :password_confirmation => "minimo", :radius => "30")
    expect(user).not_to be_valid
  end

  it "Invalid same email" do
    user1 = User.create(:name => "name1", :surname => "surname1", :username => "username1", :email => "email@test.it", :password => "minimo", :password_confirmation => "minimo", :radius => "30", :cap => "00015")
    user2 = User.create(:name => "name2", :surname => "surname2", :username => "username2", :email => "email@test.it", :password => "minimo", :password_confirmation => "minimo", :radius => "30", :cap => "00015")
    expect(user2).not_to be_valid
  end
end