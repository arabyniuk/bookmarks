require 'rails_helper'

describe LinksController, type: :request do
  it "redirect to main page" do
    visit "/ali"
    page.should have_content 'Bookmarks'
  end

  describe "with user session" do
    before { sign_in_as_a_user }

    it "bla" do
      visit "/"
      page.should have_content 'Category'
    end
  end
end
