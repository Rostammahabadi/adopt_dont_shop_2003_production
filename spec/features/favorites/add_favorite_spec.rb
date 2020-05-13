require 'rails_helper'

RSpec.describe "When a user adds pets to their cart" do
    it "displays a message letting them know it was added to favorites" do
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
        click_on "Favorite"

        expect(page).to have_content("#{pet_1.name} has been added to favorites.")
        expect(current_path).to eq("/pets/#{pet_1.id}")
    end

    it "displays the total number of favorited pets" do
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

        pet_2 = Pet.create( name:    "Spot",
                                    image: "https://i.pinimg.com/originals/47/4e/7d/474e7d2479512428a1a4716d5d1656eb.jpg",
                                    age:    "10",
                                    sex:   "M",
                                    description: "A dog looking for a loving home",
                                    shelter_id: shelter_1.id,
                                    adoption_status: "Adoptable")

        visit "/shelters"
        save_and_open_page
        expect(page).to have_content("Favorites: 0")

        visit "/pets/#{pet_1.id}"
        click_on "Favorite"

        expect(page).to have_content("Favorites: 1")

        visit "/pets/#{pet_2.id}"
        click_on "Favorite"

        expect(page).to have_content("Favorites: 2")
    end
end