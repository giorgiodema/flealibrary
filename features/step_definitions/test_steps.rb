def login(email, password)
    visit new_user_session_path
    fill_in "Email", :with => email
    fill_in "Password", :with => password
    click_button('Log in session')
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
    click_button('Sign up registration')
end

def searchuser
    fill_in "textform", :with => "name_test"
    click_button("searchbutton")
end

def searchads
    fill_in "adsform", :with => "altro_titolo_test"
    click_button("searchads")
end

def create_user
    User.create(:name=>'name_test', :surname=>'surname_test', :username=>'username_test', :email=>'email@test.it', :password=>'password', :cap=>'00015', :radius=>'30', :role=>'booklover')
end

def create_another_user
    User.create(:name=>'name', :surname=>'surname', :username=>'username', :email=>'email@email.it', :password=>'password', :cap=>'00015', :radius=>'30', :role=>'booklover')
end

def create_an_ad
    create_user
    user = find_user
    Ad.create(:user_id => user.id, :list_type => 0, :book_title => "titolo_test", :book_authors => "autore_test", :link_to_coverbook => "http://books.google.com/books/content?id=S85NCwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api",:publisher => "publisher_test", :identifier => "identifier_test", :google_id => "google_id_test")
end

def create_another_ad
    create_another_user
    user = find_another_user
    Ad.create(:user_id => user.id, :list_type => 0, :book_title => "altro_titolo_test", :book_authors => "autore_test", :link_to_coverbook => "http://books.google.com/books/content?id=S85NCwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api",:publisher => "publisher_test", :identifier => "identifier_test", :google_id => "google_id_test")
end

def create_wish_ad
    user = find_user
    Ad.create(:user_id => user.id, :list_type => 0, :book_title => "titolo_test", :book_authors => "autore_test", :link_to_coverbook => "http://books.google.com/books/content?id=S85NCwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api",:publisher => "publisher_test", :identifier => "identifier_test", :google_id => "google_id_test")
end

def create_gift_ad
    user = find_user
    Ad.create(:user_id => user.id, :list_type => 1, :book_title => "titolo_test", :book_authors => "autore_test", :link_to_coverbook => "http://books.google.com/books/content?id=S85NCwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api",:publisher => "publisher_test", :identifier => "identifier_test", :google_id => "google_id_test")
end

def create_favourite
    user = find_user
    ad = find_another_ad
    Favourite.create(:user_id => user.id, :ad_id => ad.id)
end

def find_user
    User.where(:email => "email@test.it").first
end

def find_another_user
    User.where(:email => "email@email.it").first
end

def find_ad
    Ad.where(:book_title => "titolo_test").first
end

def find_another_ad
    Ad.where(:book_title => "altro_titolo_test").first
end


def find_favourite
    user = find_user
    Favourite.where(:user_id => user.id).first
end

#GIVEN
Given /^I exist as (.+)$/ do |role|
    @user = create_user
end

Given /^I don't exist as (.+)$/ do |role|
    User.all.each do |user|
        user.destroy
    end
    @user = nil
end

Given /^I am not logged in$/ do
    page.has_button?('loginbutton')
end

Given /^I am logged in$/ do
    @user = find_user
    login(@user.email, 'password')
end

Given /^I am logged in as other user$/ do
    create_another_user
    @user = find_another_user
    login(@user.email, 'password')
end

Given /^I am in (.+) page$/ do |page|
    if page == "home"
        visit root_path
    end
    if page == "profile"
        visit '/users/profile/'+find_user.id.to_s
    end
    if page == "books_result"
        visit '/books_result/'
    end
    if page == "ads_list"
        visit '/ads_list'
    end
    if page == "Wish_Listpage"
        visit '/profile/wish_list/'+find_user.id.to_s
    end

end

Given /^another user exists$/ do
    create_user
end

Given /^exist another ad$/ do
    create_another_ad
end

Given /^exist an ad$/ do
    create_an_ad
end

#WHEN
When /^I login$/ do
    @user = find_user
    if @user == nil
        login('mail@test.it', 'password')
    else 
        login(@user.email,'password')
    end
end

When /^I register as (.+), (.+)$/ do |email, password|
    signup(email, password)
    @user = User.where(:email => email).first
end

When /^I search (.+) user$/ do |name|
    searchuser
end
When /^I search for ads$/ do
    searchads
end
When /^I follow (.+)/ do |link|
    click_link(link)
end

#THEN
Then /^I should see admin button$/ do
    page.has_button?('adminbutton')
end 

Then /^I should not see admin button$/ do
    save_and_open_page
    page.has_no_button?('adminbutton')
end 

Then /^I should see "name_test"$/ do
    page.has_link?("name_test")
end

Then /^I should see "(.+)" message$/ do |element|
    page.has_text?(element)
end

Then /^I should be signed in$/ do
    page.has_button?("logoutbutton") && page.has_no_button?("signupbutton") && page.has_no_button?("loginbutton")
end

Then /^I should be in (.+) page$/ do |name|
    id_page = '#'+name+'page'
    find(id_page)
end

Then /^it should be in the (.+) ad database$/ do |tipo|
    if tipo == "wish"
        create_wish_ad
        ad = find_ad
        expect(ad.book_title).to eq("titolo_test")
    elsif tipo == "gift"
        create_gift_ad
        ad = find_ad
        expect(ad.book_title).to eq("titolo_test")
    else
        create_favourite
        fav = find_favourite
        ad = find_another_ad
        expect(ad.book_title).to eq("altro_titolo_test")
    end
end

Then /^it shouldn't be in the wish ad database$/ do
    ad = find_ad
    expect(ad).to eq(nil)
end