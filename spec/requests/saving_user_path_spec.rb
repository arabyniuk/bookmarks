require 'rails_helper'

describe LinksController do
  it "redirect to main page" do
    visit "/ali"
    expect(page).to have_content 'Bookmarks'
  end

  describe "with user session" do
    before { sign_in_as_a_user }

    it "user page" do
      visit "/"
      expect(page).to have_content 'Category'
    end

    it "no records" do
      expect(Link.all.size).to eq(0)
    end

    it "saved user input" do
      visit "/http://google.com"
      expect(Link.all.size).to eq(1)
    end

    describe "with subdomain" do
      it "has subdomains" do
        switch_to_subdomain("subdomain")
        visit root_path
        expect(Category.all.size).to eq(1)
      end

      it "saved user input with category" do
        switch_to_subdomain("subdomain")
        visit "/http://google.com"
        expect(Link.all.size && Category.all.size).to eq(1)
      end
    end
  end
end
