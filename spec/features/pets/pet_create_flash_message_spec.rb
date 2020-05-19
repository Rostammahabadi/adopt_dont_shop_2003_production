require 'rails_helper'

RSpec.describe "Create pet page", type: :feature do
    it "will flash a message if no field is filled out" do
      shelter_1 = Shelter.create( name:    "4 Paws Rescue",
                                  address: "6567 W Long Dr.",
                                  city:    "Littleton",
                                  state:   "CO",
                                  zip:     "80123")


      visit("/shelters/#{shelter_1.id}/pets/new")
      click_on("Create Pet")
      expect(page).to have_content("Name can't be blank, Image can't be blank, Description can't be blank, Age can't be blank, Sex can't be blank")
      expect(current_path).to eq("/shelters/#{shelter_1.id}/pets/new")

      fill_in :name, with: "Teddy"
      click_on("Create Pet")
      expect(page).to have_content("Image can't be blank, Description can't be blank, Age can't be blank, Sex can't be blank")
      expect(current_path).to eq("/shelters/#{shelter_1.id}/pets/new")

      fill_in :name, with: "Teddy"
      fill_in :image, with: "URL"
      click_on("Create Pet")
      expect(page).to have_content("Description can't be blank, Age can't be blank, Sex can't be blank")
      expect(current_path).to eq("/shelters/#{shelter_1.id}/pets/new")

      fill_in :name, with: "Teddy"
      fill_in :image, with: "URL"
      fill_in :description, with: "Dog"
      click_on("Create Pet")
      expect(page).to have_content("Age can't be blank, Sex can't be blank")
      expect(current_path).to eq("/shelters/#{shelter_1.id}/pets/new")

      fill_in :name, with: "Teddy"
      fill_in :image, with: "URL"
      fill_in :description, with: "Dog"
      fill_in :age, with: 32
      click_on("Create Pet")
      expect(page).to have_content("Sex can't be blank")
      expect(current_path).to eq("/shelters/#{shelter_1.id}/pets/new")

      fill_in :name, with: "Teddy"
      fill_in :image, with: "URL"
      fill_in :description, with: "Dog"
      fill_in :age, with: 32
      fill_in :sex, with: "Male"
      click_on("Create Pet")
      expect(current_path).to eq("/shelters/#{shelter_1.id}/pets")
    end

  end
