require 'rails_helper'

RSpec.describe Message, type: :model do

    it "create message" do
        user1 = User.create(:name => "name1", :surname => "surname1", :username => "username1", :email => "email1@test.it", :password => "minimo", :password_confirmation => "minimo", :radius => "30", :cap => "00015")
        user2 = User.create(:name => "name2", :surname => "surname2", :username => "username2", :email => "email2@test.it", :password => "minimo", :password_confirmation => "minimo", :radius => "30", :cap => "00015")
        chat = Chat.create(:created_at => DateTime.now , :updated_at => DateTime.now, :owner_id => user1.id, :guest_id => user2.id)
        message = Message.create(:created_at => DateTime.now , :updated_at => DateTime.now, :text => "ciao", :read => "false", :chat_id => chat.id)
        expect(Message.first).to eq(message)
    end

    it "valid message" do
        user1 = User.create(:name => "name1", :surname => "surname1", :username => "username1", :email => "email1@test.it", :password => "minimo", :password_confirmation => "minimo", :radius => "30", :cap => "00015")
        user2 = User.create(:name => "name2", :surname => "surname2", :username => "username2", :email => "email2@test.it", :password => "minimo", :password_confirmation => "minimo", :radius => "30", :cap => "00015")
        chat = Chat.create(:created_at => DateTime.now , :updated_at => DateTime.now, :owner_id => user1.id, :guest_id => user2.id)
        message = Message.create(:created_at => DateTime.now , :updated_at => DateTime.now, :text => "ciao", :read => "false", :chat_id => chat.id)
        expect(message).to be_valid
    end

    it "invalid message" do
        message = Message.create(:created_at => DateTime.now , :updated_at => DateTime.now, :text => "ciao", :read => "false")
        expect(message).not_to be_valid
    end

end