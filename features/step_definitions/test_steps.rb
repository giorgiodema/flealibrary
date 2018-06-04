def fill_element(name, value)
    element = page.find(name)
    element.set(value)
end

def login
    visit '/users/sign_in'
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => @user.password
    click_button('Log in session')
end

def create_user
    @user = User.create(:name=>'name_test', :surname=>'surname_test', :username=>'username_test', :email=>'email@test.it', :password=>'password', :cap=>'00000', :radius=>'0')
end

def find_user
    @user = User.where(username: 'username_test').first
end

#GIVEN
Given /^I exist as a user$/ do
    create_user
end

Given /^I am not logged in$/ do
    page.has_content?('Log in')
end

#WHEN
When /^I login with valid credentials/ do
    find_user
    login
end

#THEN
Then /^I see a successful sign in message/ do
    page.has_content?("Signed in successfully.")
end

Then /^I should be signed in$/ do
    page.has_content? "Log out"
    page.has_no_content? "Sign up"
    page.has_no_content? "Log in"
end

Then /^I should be in profile/ do
    page.has_content? "Profile"
end