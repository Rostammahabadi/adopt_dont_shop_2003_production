require 'rails_helper'

describe "When I visit the shelter index Page", type: :feature do
    it "has links to update next to the shelters" do

        shelter_1 = Shelter.create( name: "4 Paws Rescue",
                    address: "6567 W Long Dr.",
                    city: "Littleton",
                    state: "CO",
                    zip: "80123")

        visit "/shelters"
        expect(page).to have_content("#{shelter_1.name}")


        click_link "Update"
        expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")
    end

    it "has delete links for each shelter" do
        shelter_1 = Shelter.create( name: "4 Paws Rescue",
                    address: "6567 W Long Dr.",
                    city: "Littleton",
                    state: "CO",
                    zip: "80123")

        visit "/shelters"
        expect(page).to have_content("#{shelter_1.name}")


        click_link "Delete"

        expect(current_path).to eq("/shelters")
        expect(page).to_not have_content("#{shelter_1.name}")
    end

    it "has shelter names as clickable links to their show page" do
        shelter_1 = Shelter.create( name: "4 Paws Rescue",
                    address: "6567 W Long Dr.",
                    city: "Littleton",
                    state: "CO",
                    zip: "80123")

        visit "/shelters"
        click_link("#{shelter_1.name}")

        expect(current_path).to eq("/shelters/#{shelter_1.id}")
    end
end