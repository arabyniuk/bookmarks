require 'spec_helper'

feature 'Sign in via Twitter' do
  background do
    User.create(provider: 'twitter',
                uid: '123545',
                email: 'as@gmail.com')
    visit '/users/sign_in'
  end

  scenario 'login page' do
    expect(page).to have_content("Sign in with Twitter")
  end

  scenario 'click login via twitter' do
    mock_auth_hash
    click_link 'Sign in with Twitter'

    expect(page).to have_content('Log out')
  end

  scenario 'click login via twitter' do
    mock_auth_hash
    click_link 'Sign in with Twitter'
    visit 'http://tweet.lvh.me:9887/'
    expect(page).to have_content('Twitter list')

    #visit '/some_test_text'
    #expect(Tweet.all.size).to eq(1)
  end
end
