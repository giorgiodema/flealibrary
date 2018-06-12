require 'rails_helper'

RSpec.describe Chat, type: :model do

    it "create chat" do
        user1 = User.create(:name => "name1", :surname => "surname1", :username => "username1", :email => "email1@test.it", :password => "minimo", :password_confirmation => "minimo", :radius => "30", :cap => "00015")
        user2 = User.create(:name => "name2", :surname => "surname2", :username => "username2", :email => "email2@test.it", :password => "minimo", :password_confirmation => "minimo", :radius => "30", :cap => "00015")
        chat = Chat.create(:created_at => DateTime.now , :updated_at => DateTime.now, :owner_id => user1.id, :guest_id => user2.id)
        expect(Chat.first).to eq(chat)
    end

    it "valid chat" do
        user1 = User.create(:name => "name1", :surname => "surname1", :username => "username1", :email => "email1@test.it", :password => "minimo", :password_confirmation => "minimo", :radius => "30", :cap => "00015")
        user2 = User.create(:name => "name2", :surname => "surname2", :username => "username2", :email => "email2@test.it", :password => "minimo", :password_confirmation => "minimo", :radius => "30", :cap => "00015")
        chat = Chat.create(:created_at => DateTime.now , :updated_at => DateTime.now, :owner_id => user1.id, :guest_id => user2.id)
        expect(chat).to be_valid
    end

    it "invalid chat" do
        chat = Chat.create(:created_at => DateTime.now , :updated_at => DateTime.now)
        expect(chat).not_to be_valid
    end

end