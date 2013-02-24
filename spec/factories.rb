FactoryGirl.define do
  factory :user do
    sequence(:login)  { |n| "Login #{n}" }
    password "foobar"
  end
end