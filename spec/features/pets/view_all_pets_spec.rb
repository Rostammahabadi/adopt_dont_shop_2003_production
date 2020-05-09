require "rails_helper"

RSpec.describe "Pets index page", type: :feature do
   it "can see all adoptable_pets" do

        shelter_1 = Shelter.create( name:    "4 Paws Rescue",
                                    address: "6567 W Long Dr.",
                                    city:    "Littleton",
                                    state:   "CO",
                                    zip:     "80123")
        shelter_2 = Shelter.create( name:    "Dumb Friends League",
                                    address: "6267 W Field St.",
                                    city:    "Denver",
                                    state:   "CO",
                                    zip:     "80127")


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
                                    adoption_status: "Pending")

        pet_3 = Pet.create( name:    "Dog Doggerson",
                                    image: "https://static01.nyt.com/images/2019/06/17/science/17DOGS/17DOGS-superJumbo.jpg",
                                    age:    "2",
                                    sex:   "F",
                                    description: "Does not like cats but otherwise very friendly.",
                                    shelter_id: shelter_2.id,
                                    adoption_status: "Adoptable")


        visit "/pets"

        expect(page).to have_content(pet_1.name)
        expect(page).to have_content(pet_1.age)
        expect(page).to have_content(pet_1.sex)
        expect(page).to have_content(pet_1.shelter.name)
        expect(page).to have_css("img[src*='https://i.pinimg.com/originals/47/4e/7d/474e7d2479512428a1a4716d5d1656eb.jpg']")
        
        expect(page).to have_content(pet_2.name)
        expect(page).to have_content(pet_2.age)
        expect(page).to have_content(pet_2.sex)
        expect(page).to have_content(pet_2.shelter.name)
        expect(page).to have_css("img[src*='https://rimage.gnst.jp/livejapan.com/public/article/detail/a/00/01/a0001799/img/basic/a0001799_main.jpg?20191118104245&q=80&rw=750&rh=536']")
        
        expect(page).to have_content(pet_3.name)
        expect(page).to have_content(pet_3.age)
        expect(page).to have_content(pet_3.sex)
        expect(page).to have_content(pet_3.shelter.name)
        expect(page).to have_css("img[src*='https://static01.nyt.com/images/2019/06/17/science/17DOGS/17DOGS-superJumbo.jpg']")
    end
end
