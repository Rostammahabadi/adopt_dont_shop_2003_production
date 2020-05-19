require "rails_helper"

RSpec.describe "When a user clicks update shelter", type: :feature do
    it "can update shelter details" do
        shelter_1 = Shelter.create( name:    "4 Paws Rescue",
                                    address: "6567 W Long Dr.",
                                    city:    "Littleton",
                                    state:   "CO",
                                    zip:     "80123")

        visit "/shelters/#{shelter_1.id}"
        click_link "Update Shelter"
        
        expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")

        fill_in :name, with: "4 Paws Animal Rescue"
        click_button "Update"

        expect(current_path).to eq("/shelters/#{shelter_1.id}")
        expect(page).to have_content("4 Paws Animal Rescue")
    end

    it "can not update when required field is blank" do
        shelter_1 = Shelter.create( name:    "4 Paws Rescue",
                                    address: "6567 W Long Dr.",
                                    city:    "Littleton",
                                    state:   "CO",
                                    zip:     "80123")

        visit "/shelters/#{shelter_1.id}"
        click_link "Update Shelter"
        
        expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")

        fill_in :name, with: ""
        click_button "Update"
        expect(page).to have_content("Name can't be blank")

        fill_in :address, with: ""
        click_button "Update"
        expect(page).to have_content("Address can't be blank")

        fill_in :city, with: ""
        click_button "Update"
        expect(page).to have_content("City can't be blank")

        fill_in :state, with: ""
        click_button "Update"
        expect(page).to have_content("State can't be blank")

        fill_in :zip, with: ""
        click_button "Update"
        expect(page).to have_content("Zip can't be blank")
    end
end