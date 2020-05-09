require 'rails_helper'

RSpec.describe "Create pet page", type: :feature do
    it "can create a new pet" do

        shelter_1 = Shelter.create( name: "4 Paws Rescue",
                            address: "6567 W Long Dr.",
                            city: "Littleton",
                            state: "CO",
                            zip: "80123")

        visit "/shelters/#{shelter_1.id}/pets"
        click_link("Create Pet")

        fill_in :name, with: "Teddy"
        fill_in :image, with: "https://i.pinimg.com/originals/47/4e/7d/474e7d2479512428a1a4716d5d1656eb.jpg"
        fill_in :description, with: "A very good boy"
        fill_in :age, with: "5"
        fill_in :sex, with: "M"
        click_button "Create Pet"

        expect(current_path).to eq("/shelters/#{shelter_1.id}/pets")
        expect(page).to have_content("Teddy")
        expect(page).to have_content("5")
        expect(page).to have_content("M")
        expect(page).to have_css("img[src*='https://i.pinimg.com/originals/47/4e/7d/474e7d2479512428a1a4716d5d1656eb.jpg']")
    end
end