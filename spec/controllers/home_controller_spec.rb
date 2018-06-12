require 'rails_helper'

RSpec.describe HomeController, :type => :controller do
    before :each do
        @user = FactoryBot.create(:user)
        sign_in @user
    end

    describe "GET welcome" do

        it "give response status 200" do
            get :welcome
            expect(response.status).to eq(200)
        end
  
        it "renders the welcome template" do
            get :welcome
            expect(response).to render_template("welcome")
        end

        it "not renders different template" do
            get :welcome
            expect(response).not_to render_template("profile")
        end

    end

    describe "GET profile" do
        
        it "renders profile template" do
            get :profile, params: { id: @user.id }
            expect(response).to render_template("profile")
        end

        it "give response status 200" do
            get :profile, params: { id: @user.id }
            expect(response.status).to eq(200)
        end

    end

    describe "GET admin_panel" do

        it "renders admin panel template" do
            get :admin_panel
            expect(response).to render_template("admin_panel")
        end

        it "give response status 200" do
            get :admin_panel
            expect(response.status).to eq(200)
        end

    end

end