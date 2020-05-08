require "rails_helper"

RSpec.describe "When I visit the Shelter show page and click delete", type: :feature do
    it "can delete the shelter" do
         shelter_1 = Shelter.create( name:    "4 Paws Rescue",
                                    address: "6567 W Long Dr.",
                                    city:    "Littleton",
                                    state:   "CO",
                                    zip:     "80123")
        visit "/shelters"
        expect(page).to have_content("4 Paws Rescue")
        visit "/shelters/#{shelter_1.id}"
        click_link "Delete"
        
        expect(current_path).to eq("/shelters")
        expect(page).to_not have_content("4 Paws Rescue")
    end
end
