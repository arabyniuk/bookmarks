require 'rails_helper'

describe LinksController do
  it "redirect to main page" do
    visit "/ali"
    expect(page).to have_content 'Find something interesting'
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

    it "save category and link both together" do
      visit 'http://search.lvh.me:9887/http://google.com'
      expect(Link.all.size && Category.all.size).to eq(1)
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

    context "wrong folder path" do
      it "same records with wrong path" do
        visit "/https://music.yandex.ua/artist/4326"
        expect(Link.all.size).to eq(0)
      end

      it "get exception with 404 link" do
        visit "/https://music.yandex.ua/artist/4326"
        expect(page).to have_css('div.alert-info')
      end
    end
  end
end
