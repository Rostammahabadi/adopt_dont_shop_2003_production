require 'rails_helper'

RSpec.describe "Create shelter page", type: :feature do
    it "can access shelter creation page" do
        visit '/shelters'
        click_link("New Shelter")
        fill_in "shelter[name]", with: "Dog Town"
        fill_in "shelter[address]", with: "1 Club Drive"
        fill_in "shelter[city]", with: "Ken Caryl"
        fill_in "shelter[state]", with: "CO"
        fill_in "shelter[zip]", with: "80123"
        click_button "submit"

        expect(page).to have_content("Dog Town")
    end
end