require 'rails_helper'

RSpec.describe "New review page", type: :feature do
    it "can create a new review" do

        shelter_1 = Shelter.create( name: "4 Paws Rescue",
                            address: "6567 W Long Dr.",
                            city: "Littleton",
                            state: "CO",
                            zip: "80123")

        visit "/shelters/#{shelter_1.id}"
        click_link("Write a Review")
        expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")

        fill_in :title, with: "Great Shelter"
        select('5', from: :rating)
        fill_in :content, with: "Very clean place with happy pets."

        click_on "Submit"
        expect(current_path).to eq("/shelters/#{shelter_1.id}")
        expect(page).to have_content("Great Shelter")
        expect(page).to have_content("5")
        expect(page).to have_content("Very clean place with happy pets.")
    end
end
