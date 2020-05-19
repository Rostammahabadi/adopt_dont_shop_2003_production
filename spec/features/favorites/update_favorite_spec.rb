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
        has_link?("Favorite")
        click_on "Favorite"

        expect(current_path).to eq("/pets/#{pet_1.id}")
        expect(page).to have_content("#{pet_1.name} has been added to favorites.")
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

        within("nav") do
            expect(page).to have_content("Favorites: 0")
        end

        visit "/pets/#{pet_1.id}"
        click_on "Favorite"

        within("nav") do
            expect(page).to have_content("Favorites: 1")
        end

        visit "/pets/#{pet_2.id}"
        click_on "Favorite"

        within("nav") do
            expect(page).to have_content("Favorites: 2")
        end    
    end

    it "changes link to 'remove from favorites' after pet has been favorited" do
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
        
        within(".pet-header") do
            expect(page).to_not have_css(".shelter-update.top")
            expect(page).to have_link("Remove from Favorites")
        end
    end

    it "removes a pet from favorites" do
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
        expect(page).to have_content("Favorites: 0")

        visit "/pets/#{pet_1.id}"
        click_on "Favorite"
        visit "/pets/#{pet_2.id}"
        click_on "Favorite"

        within("nav") do
            expect(page).to have_content("Favorites: 2")
        end

        visit "/pets/#{pet_2.id}"
        within(".pet-header") do
            expect(page).to_not have_css(".add-favorite")
            expect(page).to have_link("Remove from Favorites")
        end
        click_on "Remove from Favorites"

        expect(current_path).to eq("/pets/#{pet_2.id}")
        expected = "#{pet_2.name} has been removed from favorites."
        expect(page).to have_content(expected)

        within("nav") do
            expect(page).to have_content("Favorites: 1")
        end
    end
end