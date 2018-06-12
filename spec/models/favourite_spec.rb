require 'rails_helper'

RSpec.describe Favourite, type: :model do

    it "create favourite" do
        user1 = User.create(:name => "name1", :surname => "surname1", :username => "username1", :email => "email1@test.it", :password => "minimo", :password_confirmation => "minimo", :radius => "30", :cap => "00015")
        user2 = User.create(:name => "name2", :surname => "surname2", :username => "username2", :email => "email2@test.it", :password => "minimo", :password_confirmation => "minimo", :radius => "30", :cap => "00015")
        ad = Ad.create(:list_type => "1" , :book_title => "gomorra", :book_authors => "saviano", :user_id => user1.id)
        favourite = Favourite.create(:user_id => user2.id, :ad_id => ad.id, :created_at => DateTime.now, :updated_at => DateTime.now)
        expect(Favourite.first).to eq(favourite)
    end

    it "valid chat" do
        user1 = User.create(:name => "name1", :surname => "surname1", :username => "username1", :email => "email1@test.it", :password => "minimo", :password_confirmation => "minimo", :radius => "30", :cap => "00015")
        user2 = User.create(:name => "name2", :surname => "surname2", :username => "username2", :email => "email2@test.it", :password => "minimo", :password_confirmation => "minimo", :radius => "30", :cap => "00015")
        ad = Ad.create(:list_type => "1" , :book_title => "gomorra", :book_authors => "saviano", :user_id => user1.id)
        favourite = Favourite.create(:user_id => user2.id, :ad_id => ad.id, :created_at => DateTime.now, :updated_at => DateTime.now)
        expect(favourite).to be_valid
    end

    it "invalid chat" do
        user1 = User.create(:name => "name1", :surname => "surname1", :username => "username1", :email => "email1@test.it", :password => "minimo", :password_confirmation => "minimo", :radius => "30", :cap => "00015")
        user2 = User.create(:name => "name2", :surname => "surname2", :username => "username2", :email => "email2@test.it", :password => "minimo", :password_confirmation => "minimo", :radius => "30", :cap => "00015")
        ad = Ad.create(:list_type => "1" , :book_title => "gomorra", :book_authors => "saviano", :user_id => user1.id)
        favourite = Favourite.create(:ad_id => ad.id, :created_at => DateTime.now, :updated_at => DateTime.now)
        expect(favourite).not_to be_valid
    end

end