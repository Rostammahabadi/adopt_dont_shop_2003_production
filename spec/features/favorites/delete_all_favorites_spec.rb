require 'rails_helper'

RSpec.describe "User can click delete all favorited pets" do
    it "will delete all favorited pets and redirect to the index page" do
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
        has_link?("Favorite")
        click_on "Favorite"
        visit("/favorites")
        within ".pet-#{pet_1.id}" do
          expect(page).to have_content("#{pet_1.name}")
        end
        expect(page).to have_css("img[src*='https://i.pinimg.com/originals/47/4e/7d/474e7d2479512428a1a4716d5d1656eb.jpg']")
        has_link?("#{pet_1.name}")
        click_link("#{pet_1.name}")
        expect(current_path).to eq("/pets/#{pet_1.id}")
    end
end
