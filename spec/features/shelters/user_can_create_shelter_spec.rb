require 'rails_helper'

RSpec.describe "Create shelter page", type: :feature do
    it "can create a new shelter" do
        visit '/shelters'
        click_link("New Shelter")

        fill_in :name, with: "Dog Town"
        fill_in :address, with: "1 Club Drive"
        fill_in :city, with: "Ken Caryl"
        fill_in :state, with: "CO"
        fill_in :zip, with: "80123"
        click_button "Create Shelter"

        expect(current_path).to eq("/shelters")
        expect(page).to have_content("Dog Town")
    end
end