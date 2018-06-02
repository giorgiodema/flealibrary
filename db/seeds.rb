# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#giorgio = User.create(:username=>"Giorgio")
#vincenzo = User.create(:username=>"Vincenzo")
#flavia = User.create(:username=>"Flavia")

#c01 = Chat.create(:owner=>giorgio,:guest=>vincenzo)
#Message.create(:chat=>c01, :text=>"Ciao vincenzone porcone", :from=>:o, :read=>true)
#Message.create(:chat=>c01, :text=>"Ciao giorgio, sei bellissimo", :from=>:g, :read=>true)

#c02 = Chat.create(:owner=>giorgio,:guest=>flavia)
#Message.create(:chat=>c02, :text=>"Ciao Fla, come stai?", :from=>:o, :read=>true)
#Message.create(:chat=>c02, :text=>"Ciao Gio, bene tu? stai studiando?", :from=>:g, :read=>true)


=begin
a = User.create(:username=>"A")
b = User.create(:username=>"B")

c = Chat.create(:owner=>a,:guest=>b)

m = Message.create(:chat=>c,:text=>"ciao a")
=end

dante = User.create(:name=>"dante", :surname=>"alighieri", :username=>"dante", :email=>"dante@gmail.com", :password=>"minimo", :role=>"superadmin", :cap=>'00000', :radius=>'0')
giorgio = User.create(:name=>"giorgio", :surname=>"dema", :username=>"giorgio", :email=>"giorgio@gmail.com", :password=>"minimo", :role=>"admin", :cap=>'00000', :radius=>'0')
vincenzo = User.create(:name=>"vincenzo", :surname=>"cas", :username=>"vincenzo", :email=>"vincenzo@gmail.com", :password=>"minimo", :role=>"admin", :cap=>'00000', :radius=>'0')
flavia = User.create(:name=>"flavia", :surname=>"mon", :username=>"flavia", :email=>"flavia@gmail.com", :password=>"minimo", :role=>"admin", :cap=>'00000', :radius=>'0')

c01 = Chat.create(:owner=>giorgio,:guest=>vincenzo)
Message.create(:chat=>c01, :text=>"Ciao vincenzone porcone", :from=>:o, :read=>true)
Message.create(:chat=>c01, :text=>"Ciao giorgio, sei bellissimo", :from=>:g, :read=>true)

c02 = Chat.create(:owner=>giorgio,:guest=>flavia)
Message.create(:chat=>c02, :text=>"Ciao Fla, come stai?", :from=>:o, :read=>true)
Message.create(:chat=>c02, :text=>"Ciao Gio, bene tu? stai studiando?", :from=>:g, :read=>true)