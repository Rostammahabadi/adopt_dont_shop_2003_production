require 'rails_helper'

RSpec.describe "Shelter show page", type: :feature do
    it "can see shelter details" do
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
        visit "/shelters/#{shelter_1.id}"

        expect(page).to have_content(shelter_1.name)
        expect(page).to have_content(shelter_1.address)
        expect(page).to have_content(shelter_1.city)
        expect(page).to have_content(shelter_1.state)
        expect(page).to have_content(shelter_1.zip)
    end
    
    it "has a link to their pets" do
        shelter_1 = Shelter.create( name:    "4 Paws Rescue",
                            address: "6567 W Long Dr.",
                            city:    "Littleton",
                            state:   "CO",
                            zip:     "80123")
        
        visit "/shelters/#{shelter_1.id}"
        click_link "View Pets"      
        expect(current_path).to eq("/shelters/#{shelter_1.id}/pets")

        click_link "Pets"
        expect(current_path).to eq("/pets")

        click_link "Shelters"
        expect(current_path).to eq("/shelters")
    end

    it "shows shelter statistics" do
        shelter1 = Shelter.create( name:    "4 Paws Rescue",
                                    address: "6567 W Long Dr.",
                                    city:    "Littleton",
                                    state:   "CO",
                                    zip:     "80123")

        visit "shelters/#{shelter1.id}"
        expect(page).to have_content ("Average Rating: N/A")
        expect(page).to have_content ("Number of Pets: 0")
        expect(page).to have_content ("Total Applications: 0")

        review1 = shelter1.reviews.create(
                title: "Awesome",
                rating: 4,
                content: "This place was amazing, really cared for their animals",
                picture: "url.url")

        review2 = shelter1.reviews.create(
                    title: "Sweet",
                    rating: 3,
                    content: "Cool place")

        pet_1 = Pet.create( name:    "Teddy",
                                    image: "https://i.pinimg.com/originals/47/4e/7d/474e7d2479512428a1a4716d5d1656eb.jpg",
                                    age:    "10",
                                    sex:   "M",
                                    description: "A sweet dog looking for a loving home",
                                    shelter_id: shelter1.id,
                                    adoption_status: "Adoptable")

        pet_2 = Pet.create( name:    "Dog-Kevin Bacon",
                                    image: "https://rimage.gnst.jp/livejapan.com/public/article/detail/a/00/01/a0001799/img/basic/a0001799_main.jpg?20191118104245&q=80&rw=750&rh=536",
                                    age:    "6",
                                    sex:   "M",
                                    description: "Loves to dance for some reason.",
                                    shelter_id: shelter1.id,
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
                address: "554 s. Sunset st.",
                city: "Albuquerque",
                state: "NM",
                zip: 50555,
                phone_number: 3859999,
                description: "I would like the pet as well."
                })
        PetApplication.create(pet_id: pet_1.id, application_id: application2.id)
        PetApplication.create(pet_id: pet_2.id, application_id: application2.id)

        application3 = Application.create({    
                name: "Coffee Maker",
                address: "554 s. Sunset st.",
                city: "Albuquerque",
                state: "NM",
                zip: 50555,
                phone_number: 3859999,
                description: "I would like the pet as well."
                })
        PetApplication.create(pet_id: pet_2.id, application_id: application3.id)

        visit("/shelters/#{shelter1.id}")
        expect(page).to have_content("Shelter Statistics")
        expect(page).to have_content ("Average Rating: 3.5")
        expect(page).to have_content ("Number of Pets: 2")
        expect(page).to have_content ("Total Applications: 3")
    end
end