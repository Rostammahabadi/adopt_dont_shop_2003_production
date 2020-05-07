require "rails_helper"

RSpec.describe "Shelter show page", type: :feature do
    it "can see shelter details" do
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
end