require 'rails_helper'

RSpec.describe "User can see all favorited pets on favorite index page" do
    it "displays a pet that have been favorited" do
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
    it "displays multiple pets that have been favorited" do
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
      click_on "Favorite"
      visit("/pets/#{pet_2.id}")
      click_on "Favorite"
      visit("/favorites")
      within ".pet-#{pet_1.id}" do
        expect(page).to have_content("#{pet_1.name}")
      end

      expect(page).to have_css("img[src*='https://i.pinimg.com/originals/47/4e/7d/474e7d2479512428a1a4716d5d1656eb.jpg']")

      within ".pet-#{pet_2.id}" do
        expect(page).to have_content("#{pet_2.name}")
      end

      expect(page).to have_css("img[src*='https://rimage.gnst.jp/livejapan.com/public/article/detail/a/00/01/a0001799/img/basic/a0001799_main.jpg?20191118104245&q=80&rw=750&rh=536']")

    end

    it "Can remove a pet from favorites" do
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
      click_on "Favorite"

      visit("/favorites")

      click_link("Remove from Favorites")
      expect(page).to have_content("#{pet_1.name} has been removed from favorites.")

      expect(page).to_not have_css(".pet-#{pet_1.id}")
      expect(current_path).to eq("/favorites")
    end
end
