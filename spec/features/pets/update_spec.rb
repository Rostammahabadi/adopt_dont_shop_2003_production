require "rails_helper"

RSpec.describe "Pets update page", type: :feature do
   it "can update pet details" do

        shelter_1 = Shelter.create( name:    "4 Paws Rescue",
                                    address: "6567 W Long Dr.",
                                    city:    "Littleton",
                                    state:   "CO",
                                    zip:     "80123")


        pet_1 = Pet.create( name:    "Teddy",
                                    image: "https://i.pinimg.com/originals/47/4e/7d/474e7d2479512428a1a4716d5d1656eb.jpg",
                                    age:    "10",
                                    sex:   "M",
                                    description: "A sweet dog looking for a loving home",
                                    shelter_id: shelter_1.id,
                                    adoption_status: "Adoptable")


        visit "/pets/#{pet_1.id}"
        click_link "Update Pet"

        expect(current_path).to eq("/pets/#{pet_1.id}/edit")

        fill_in :name, with: "Ted"
        fill_in :image, with: "https://i.pinimg.com/originals/47/4e/7d/474e7d2479512428a1a4716d5d1656eb.jpg"
        fill_in :description, with: "A very good boy"
        fill_in :age, with: "5"
        fill_in :sex, with: "M"
        click_button "Update Pet"

        expect(current_path).to eq("/pets/#{pet_1.id}")
        expect(page).to have_content("Ted")
        expect(page).to have_content("5")
        expect(page).to have_content("M")
        expect(page).to have_content("A very good boy")
        expect(page).to have_content("Adoptable")
        expect(page).to have_css("img[src*='https://i.pinimg.com/originals/47/4e/7d/474e7d2479512428a1a4716d5d1656eb.jpg']")
    end
end
