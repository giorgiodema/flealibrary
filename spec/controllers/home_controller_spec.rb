require 'rails_helper'

RSpec.describe HomeController, :type => :controller do

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

    #installare gemma factorybot!
    describe "GET profile" do
        login
        
        it "renders profile template" do
            get :profile
            expect(response).to render_template("profile")
        end

    end

end