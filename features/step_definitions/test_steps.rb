def fill_element(name, value)
    element = page.find(name)
    element.set(value)
end

def login(email, password)
    visit '/users/sign_in'
    fill_in "Email", :with => email
    fill_in "Password", :with => password
    click_button('loginbutton')
end

def signup(email, password)
    visit new_user_registration_path
    fill_in "Name", :with => "name_test"
    fill_in "Surname", :with => "surname_test"
    fill_in "Username", :with => "username_test"
    fill_in "Email", :with => email
    fill_in "Password", :with => password
    fill_in "Password confirmation", :with => password
    fill_in "Cap", :with => "00015"
    #fill_in "Radius", :with => "30".select_option
    #.find("option[value='30']").select_option
    #find("Radius").find(:xpath, 'option[6]').select_option
    select "30", :from => "Radius"
    click_button("signupbutton")
end

def create_user
    @user = User.create(:name=>'name_test', :surname=>'surname_test', :username=>'username_test', :email=>'email@test.it', :password=>'password', :cap=>'00015', :radius=>'30')
end

def find_user
    @user = User.where(:email => "mail@test.it").first
end

#GIVEN
Given /^I exist as a user$/ do
    create_user
end

Given /^I don't exist as a user$/ do
    @user = nil
end

Given /^I am not logged in$/ do
    #page.has_no_content?("Log in")
    #page.find_button('Log in')[:value]
end

#WHEN
When /^I login$/ do
    find_user
    if @user == nil
        login('mail@test.it', 'password')
    else 
        login(@user.email, @user.password)
    end
end

When /^I register as (.+), (.+)$/ do |email, password|
    signup(email, password)
    @user = User.where(:email => email).first
    @current_user = @user
end

#THEN
Then /^I should see "(.+)"$/ do |message|
    page.has_content?(message)
end

Then /^I should be signed in$/ do
    page.has_content? "Log out"
    page.has_no_content? "Sign up"
    page.has_no_content? "Log in"
end

Then /^I should be in (.+) page$/ do |name|
    page.has_content? name+"page"
end