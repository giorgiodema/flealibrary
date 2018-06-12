module SpecTestHelper

  def sign_in(user)
    if user.nil?
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
      allow(controller).to receive(:current_user).and_return(nil)
    else
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end
  end

  def create_wish_ad(user)
    Ad.create!(:user_id => user.id, :list_type => 0, :book_title => "Gomorra",
      :book_authors => "Roberto Saviano", :link_to_coverbook => "http://books.google.com/books/content?id=m-KftFxpQk8C&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api",
      :publisher => "Edizioni Mondadori",
      :google_id => "m-KftFxpQk8C")
  end

end