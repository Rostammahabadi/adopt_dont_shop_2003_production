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
        click_link "Delete Shelter"

        expect(current_path).to eq("/shelters")
        expect(page).to_not have_content("4 Paws Rescue")
    end
    it "can delete shelter with review and pets" do
      shelter_1 = Shelter.create( name:    "4 Paws Rescue",
                                 address: "6567 W Long Dr.",
                                 city:    "Littleton",
                                 state:   "CO",
                                 zip:     "80123")

      review1 = shelter_1.reviews.create(
        title: "Awesome",
        rating: 4,
        content: "This place was amazing, really cared for their animals",
        picture: "url.url"
      )
      pet_1 = Pet.create( name:    "Teddy",
                                  image: "https://i.pinimg.com/originals/47/4e/7d/474e7d2479512428a1a4716d5d1656eb.jpg",
                                  age:    "10",
                                  sex:   "M",
                                  description: "A sweet dog looking for a loving home",
                                  shelter_id: shelter_1.id,
                                  adoption_status: "Adoptable")

      visit("/shelters")
      click_link("Delete")

      expect(current_path).to eq("/shelters")
      expect(page).to_not have_content("4 Paws Rescue")
    end
end
