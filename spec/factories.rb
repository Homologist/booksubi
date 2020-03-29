FactoryBot.define do
  factory :user do
    email { "mikde@gmail.com" }
    password { "password"} 
    password_confirmation { "password" }
  end

  factory :csv_book do
    name { "first.csv" }
    uuid { "uuid"}
    user
  end
end
