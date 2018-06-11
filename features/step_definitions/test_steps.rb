def login(email, password)
    visit new_user_session_path
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
    select "30", :from => "Radius"
    click_button("signupbutton")
end

def searchuser(name)
    fill_in "Search User", :with => name
    click_button("searchbutton")
end

def create_user(role)
    User.new(:name=>'name_test', :surname=>'surname_test', :username=>'username_test', :email=>'email@test.it', :password=>'password', :cap=>'00015', :radius=>'30', :role=>role).save!
end

def create_another_user(role)
    User.new(:name=>'name', :surname=>'surname', :username=>'username', :email=>'email@email.it', :password=>'password', :cap=>'00015', :radius=>'30', :role=>role).save!
end

def find_user
    User.where(:email => "email@test.it").first
end

def find_another_user
    User.where(:email => "email@email.it").first
end

#GIVEN
Given /^I exist as (.+)$/ do |role|
    @user = create_user(role)
end

Given /^I don't exist as (.+)$/ do |role|
    User.all.each do |user|
        user.destroy
    end
    @user = nil
end

Given /^I am not logged in$/ do
    page.has_button?('Log in')
end

Given /^I am logged in$/ do
    create_another_user("booklover")
    @user = find_another_user
    login(@user.email, @user.password)
end

Given /^I am in (.+) page$/ do |page|
    if page == "home"
        visit root_path
    end
end

#WHEN
When /^I login$/ do
    @user = find_user
    if @user == nil
        login('mail@test.it', 'password')
    else 
        login(@user.email, @user.password)
    end
end

When /^I register as (.+), (.+)$/ do |email, password|
    signup(email, password)
    @user = User.where(:email => email).first
end

When /^I search (.+) user$/ do |name|
    searchuser(name)
end

#THEN
Then /^I should see admin button$/ do
    page.has_button?('Admin panel')
end 

Then /^I should not see admin button$/ do
    page.has_no_button?('Admin panel')
end 

Then /^I should see "name_test"$/ do
    page.has_link?("name_test")
end

Then /^I should see "(.+)" message$/ do |element|
    page.has_text?(element)
end

Then /^I should be signed in$/ do
    page.has_button? "Log out"
    page.has_no_button? "Sign up"
    page.has_no_button? "Log in"
end

Then /^I should be in (.+) page$/ do |name|
    page.has_content? name+"page"
end