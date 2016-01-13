FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "some_mail#{n}@mail.com" }
    provider "twitter"
    password "secret123"
    password_confirmation "secret123"
  end

  trait :with_twitter_account do
    after(:create) do |user|
      create(:user_account, :twitter, user: user)
    end
  end
end

