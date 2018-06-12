FactoryBot.define do
    factory :user do
        id "1"
        name "name"
        surname "surname"
        username "username"
        email "mail@test.it"
        password "password"
        password_confirmation "password"
        radius "30"
        cap "00015"
        role "admin"
    end
end