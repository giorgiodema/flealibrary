
Given "I am a booklover" do
    @booklover = User.create(:name=>'name_test', :surname=>'surname_test', :username=>'username_test', :email=>'email@test.it', :password=>'password', :cap=>'00000', :radius=>'0')
end

When "I login" do |:email|
    @user = User.find_by()
end