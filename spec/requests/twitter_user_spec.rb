require 'spec_helper'
require 'ostruct'

feature "Sign in via Twitter" do
  background do
    User.create(provider: 'twitter',
                uid: '123545',
                email: 'as@gmail.com')
    visit '/users/sign_in'
  end

  scenario "login page" do
    expect(page).to have_content("Sign in with Twitter")
  end

  scenario "click login via twitter" do
    mock_auth_hash
    click_link 'Sign in with Twitter'

    expect(page).to have_content('Log out')
  end

  feature "twitter auth" do
    background do
      mock_auth_hash
      click_link "Sign in with Twitter"
      visit "http://tweet.lvh.me:9887/"
      struck_obj = OpenStruct.new(id: 1)
      allow_any_instance_of(TwitterController).to receive(:twitter_job).and_return(struck_obj)
    end

    scenario "click login via twitter" do
      expect(page).to have_content('Twitter list')
    end

    scenario "click login via twitter" do
      visit 'http://tweet.lvh.me:9887/some_message'
      expect(Tweet.all.size).to eq(1)
    end

    scenario "click login via twitter" do
      visit 'http://tweet.lvh.me:9887/some_message&d=40'
      expect(Tweet.last.delay).to be > Time.now
    end
  end
end
