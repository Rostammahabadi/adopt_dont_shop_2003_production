require 'rails_helper'

RSpec.describe "User can crate new application" do
    it "will take user to application page where they can fill out information" do
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

      pet_2 = Pet.create( name:    "Dog-Kevin Bacon",
                                  image: "https://rimage.gnst.jp/livejapan.com/public/article/detail/a/00/01/a0001799/img/basic/a0001799_main.jpg?20191118104245&q=80&rw=750&rh=536",
                                  age:    "6",
                                  sex:   "M",
                                  description: "Loves to dance for some reason.",
                                  shelter_id: shelter_1.id,
                                  adoption_status: "Adoptable")

      visit("/pets/#{pet_1.id}")
      click_on("Favorite")
      visit("/pets/#{pet_2.id}")
      click_on("Favorite")
      visit("/favorites")
      has_link?("New Application")
      click_link("New Application")
      select("#{pet_1.name}")
      fill_in :name, with: "Alex"
      fill_in :address, with: "123 West 3rd St"
      fill_in :city, with: "Sterling"
      fill_in :state, with: "Virginia"
      fill_in :zip, with: 85257
      fill_in :phone_number, with: "7034630729"
      fill_in :description, with: "Id be a great fit because I like dogs"
      click_on("Submit")
      expect(current_path).to eq("/favorites")
      expect(page).to have_content("Your application for #{pet_1.name} has been submitted.")
      within(".pet-entry") do
        expect(page).to_not have_content("Teddy")
        expect(page).to_not have_content("A sweet dog looking for a loving home")
        expect(page).to_not have_content(10)
      end
    end
    it "will show warning message when field are entered" do
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

      pet_2 = Pet.create( name:    "Dog-Kevin Bacon",
                                  image: "https://rimage.gnst.jp/livejapan.com/public/article/detail/a/00/01/a0001799/img/basic/a0001799_main.jpg?20191118104245&q=80&rw=750&rh=536",
                                  age:    "6",
                                  sex:   "M",
                                  description: "Loves to dance for some reason.",
                                  shelter_id: shelter_1.id,
                                  adoption_status: "Adoptable")

      visit("/pets/#{pet_1.id}")
      click_on("Favorite")
      visit("/pets/#{pet_2.id}")
      click_on("Favorite")
      visit("/favorites")
      has_link?("New Application")
      click_link("New Application")
      select("#{pet_1.name}")
      click_on("Submit")
      expect(page).to have_content("You must fill out all fields")
      expect(current_path).to eq("/applications/new")
    end

end
