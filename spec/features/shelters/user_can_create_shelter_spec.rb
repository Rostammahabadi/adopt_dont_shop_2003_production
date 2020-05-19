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

    it "will not create a shelter if all required fields are not filled in" do
        visit '/shelters'
        click_link("New Shelter")
        click_button "Create Shelter"
        expect(page).to have_content("Name can't be blank")
        expect(page).to have_content("Address can't be blank")
        expect(page).to have_content("City can't be blank")
        expect(page).to have_content("State can't be blank")
        expect(page).to have_content("Zip can't be blank")

        fill_in :name, with: "Dog Town"
        click_button "Create Shelter"
        expect(page).to have_content("Address can't be blank")
        expect(page).to have_content("City can't be blank")
        expect(page).to have_content("State can't be blank")
        expect(page).to have_content("Zip can't be blank")

        fill_in :address, with: "1 Club Drive"
        click_button "Create Shelter"
        expect(page).to have_content("City can't be blank")
        expect(page).to have_content("State can't be blank")
        expect(page).to have_content("Zip can't be blank")

        fill_in :city, with: "Ken Caryl"
        click_button "Create Shelter"
        expect(page).to have_content("State can't be blank")
        expect(page).to have_content("Zip can't be blank")

        fill_in :state, with: "CO"
        click_button "Create Shelter"
        expect(page).to have_content("Zip can't be blank")

        fill_in :zip, with: "80123"
        click_button "Create Shelter"

        expect(current_path).to eq("/shelters")
        expect(page).to have_content("Dog Town")
    end
end