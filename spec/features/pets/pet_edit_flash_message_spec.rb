require 'rails_helper'

RSpec.describe "Edit pet page", type: :feature do
    it "will flash a message if no field is filled out" do
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
      visit("/pets/#{pet_1.id}/edit")
      fill_in :name, with: ""
      fill_in :image, with: ""
      fill_in :description, with: ""
      fill_in :age, with: ""
      fill_in :sex, with: ""
      click_on("Update Pet")
      expect(page).to have_content("Name can't be blank, Image can't be blank, Description can't be blank, Age can't be blank, Sex can't be blank")
      expect(current_path).to eq("/pets/#{pet_1.id}/edit")

      fill_in :name, with: ""
      click_on("Update Pet")
      expect(page).to have_content("Name can't be blank")
      expect(current_path).to eq("/pets/#{pet_1.id}/edit")

      fill_in :name, with: ""
      fill_in :image, with: ""
      click_on("Update Pet")
      expect(page).to have_content("Name can't be blank, Image can't be blank")
      expect(current_path).to eq("/pets/#{pet_1.id}/edit")

      fill_in :name, with: ""
      fill_in :image, with: ""
      fill_in :description, with: ""
      click_on("Update Pet")
      expect(page).to have_content("Name can't be blank, Image can't be blank, Description can't be blank")
      expect(current_path).to eq("/pets/#{pet_1.id}/edit")

      fill_in :name, with: ""
      fill_in :image, with: ""
      fill_in :description, with: ""
      fill_in :age, with: ""
      click_on("Update Pet")
      expect(page).to have_content("Name can't be blank, Image can't be blank, Description can't be blank, Age can't be blank")
      expect(current_path).to eq("/pets/#{pet_1.id}/edit")

      fill_in :name, with: "Teddy"
      fill_in :image, with: "URL"
      fill_in :description, with: "Dog"
      fill_in :age, with: 32
      fill_in :sex, with: "Male"
      click_on("Update Pet")
      expect(current_path).to eq("/pets/#{pet_1.id}")
    end

  end
