FactoryGirl.define do
  factory :user do
    sequence(:email)      { |n| "some_mail#{n}@mail.com" }
    password "secret123"
    password_confirmation "secret123"
  end
end

