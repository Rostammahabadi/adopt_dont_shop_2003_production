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
end
