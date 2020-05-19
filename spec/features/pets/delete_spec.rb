require "rails_helper"

RSpec.describe "When I visit the pet show page and click delete", type: :feature do
    it "can delete the pet" do
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

        visit "/pets"
        expect(page).to have_content("Teddy")
        expect(page).to have_content("10")
        expect(page).to have_content("M")
        expect(page).to have_css("img[src*='https://i.pinimg.com/originals/47/4e/7d/474e7d2479512428a1a4716d5d1656eb.jpg']")
        
        visit "/pets/#{pet_1.id}"
        click_link "Delete Pet"
        
        expect(current_path).to eq("/pets")

        expect(page).to_not have_content("Teddy")
        expect(page).to_not have_content("10")
        expect(page).to_not have_content("M")
        expect(page).to_not have_css("img[src*='https://i.pinimg.com/originals/47/4e/7d/474e7d2479512428a1a4716d5d1656eb.jpg']")
    end

    it "can't delete a pet with approved applications" do
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

        application1 = Application.create({    
                name: "Hambone Fakenamington",
                address: "555 s. Sunset st.",
                city: "Los Angeles",
                state: "CA",
                zip: 55555,
                phone_number: 3459999,
                description: "I want the pet"
                })
        PetApplication.create(pet_id: pet_1.id, application_id: application1.id)


        visit "/applications/#{application1.id}"
        click_link "Approve"
        expect(current_path).to eq("/pets/#{pet_1.id}")

        expect(page).to have_content("Adoption status: Pending")
        expect(page).to have_content("On hold for Hambone Fakenamington")
        
        click_link "Delete Pet"
        
        expect(current_path).to eq("/pets/#{pet_1.id}")
        expect(page).to have_content("This pet cannot be deleted due to approved applications")

        visit("/pets")
        click_link "Delete"
        
        expect(current_path).to eq("/pets")
        expect(page).to have_content("This pet cannot be deleted due to approved applications")
    end

    it "removes a pet from favorites when it is deleted" do
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

        application1 = Application.create({    
                name: "Hambone Fakenamington",
                address: "555 s. Sunset st.",
                city: "Los Angeles",
                state: "CA",
                zip: 55555,
                phone_number: 3459999,
                description: "I want the pet"
                })
        PetApplication.create(pet_id: pet_1.id, application_id: application1.id)

        application2 = Application.create({    
                name: "Coffee Maker",
                address: "555 s. Sunset st.",
                city: "Los Angeles",
                state: "CA",
                zip: 55555,
                phone_number: 3459999,
                description: "I want the pet"
                })
        PetApplication.create(pet_id: pet_1.id, application_id: application2.id)


        visit "/pets/#{pet_1.id}"
        click_link "Favorite"
        within("nav") do
            expect(page).to have_content("Favorites: 1")
        end
        
        click_link "Delete Pet"
        
        expect(current_path).to eq("/pets")
        expect(page).to_not have_content("Teddy")
        expect(page).to_not have_content("10")
        expect(page).to_not have_content("M")
        expect(page).to_not have_css("img[src*='https://i.pinimg.com/originals/47/4e/7d/474e7d2479512428a1a4716d5d1656eb.jpg']")

        within("nav") do
            expect(page).to have_content("Favorites: 0")
        end

        visit("/favorites")
        expect(page).to have_content("You have no favorited pets")
    end
end
