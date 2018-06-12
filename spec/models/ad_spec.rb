require 'rails_helper'

RSpec.describe Ad, type: :model do

    it "create ad" do
        user = User.create(:name => "name", :surname => "surname", :username => "username", :email => "email@test.it", :password => "minimo", :password_confirmation => "minimo", :radius => "30", :cap => "00015")
        ad = Ad.create(:list_type => "1" , :book_title => "gomorra", :book_authors => "saviano", :user_id => user.id)
        expect(Ad.where(:book_title => "gomorra").first).to eq(ad)
    end

    it "valid ad" do
        user = User.create(:name => "name", :surname => "surname", :username => "username", :email => "email@test.it", :password => "minimo", :password_confirmation => "minimo", :radius => "30", :cap => "00015")
        ad = Ad.create(:list_type => "1" , :book_title => "gomorra", :book_authors => "saviano", :user_id => user.id)
        expect(ad).to be_valid
    end

    it "invalid ad" do
        ad = Ad.create(:list_type => "1" , :book_title => "gomorra", :book_authors => "saviano")
        expect(ad).not_to be_valid
    end


end