require "rails_helper"

RSpec.describe "Pets show page", type: :feature do
   it "can see individual pet details" do

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
        
        expect(page).to have_content(pet_1.name)
        expect(page).to have_content(pet_1.age)
        expect(page).to have_content(pet_1.sex)
        expect(page).to have_content(pet_1.description)
        expect(page).to have_content(pet_1.adoption_status)
        expect(page).to have_css("img[src*='https://i.pinimg.com/originals/47/4e/7d/474e7d2479512428a1a4716d5d1656eb.jpg']")
    end
end
