require 'rails_helper'

#describe LinksController, :type => :request do
describe LinksController do
  login_user   
  #before { visit new_user_session_path }

  #describe "set current link" do

  #  before do
  #    user = FactoryGirl.create :user
  #    user.save!
  #    fill_in "Email", with: user.email
  #    fill_in "Password", with: user.password
  #    click_on 'Log in'
  #  end
  #  it { page.should have_content 'Signed in successfully.' }

    it "should return something" do
      #get 'http://lvh.me:3000/http://google.com'
      visit root_path
      page.should have_content 'Signed in successfully.'
    end
  #end
end
