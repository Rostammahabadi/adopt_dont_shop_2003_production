require "rails_helper"

RSpec.describe "When I visit the Shelter show page and click delete while they have pets with pending adoption status", type: :feature do
    it "flashes a message and redirects back to show page" do

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

      application1 = Application.create({
        name: "Hambone Fakenamington",
        address: "555 s. Sunset st.",
        city: "Los Angeles",
        state: "CA",
        zip: 55555,
        phone_number: 3459999,
        description: "I want the pet"
      })

      application2 = Application.create({
        name: "Coffee Maker",
        address: "554 s. Sunset st.",
        city: "Albuquerque",
        state: "NM",
        zip: 50555,
        phone_number: 3859999,
        description: "I would like the pet as well."
      })

      PetApplication.create(pet_id: pet_1.id, application_id: application1.id, approved: true)
      PetApplication.create(pet_id: pet_1.id, application_id: application2.id)

      visit("/shelters")
      click_on("Delete")
      expect(page).to have_content("The shelter can not be deleted due to pending application")
      expect(current_path).to eq("/shelters/#{shelter_1.id}")
  end
  it "Will not delete a shelter from the shelter show page" do
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
                                adoption_status: "Pending")

    application1 = Application.create({
      name: "Hambone Fakenamington",
      address: "555 s. Sunset st.",
      city: "Los Angeles",
      state: "CA",
      zip: 55555,
      phone_number: 3459999,
      description: "I want the pet"
    })

    application2 = Application.create({
      name: "Coffee Maker",
      address: "554 s. Sunset st.",
      city: "Albuquerque",
      state: "NM",
      zip: 50555,
      phone_number: 3859999,
      description: "I would like the pet as well."
    })

    PetApplication.create(pet_id: pet_1.id, application_id: application1.id)
    PetApplication.create(pet_id: pet_1.id, application_id: application2.id)

    visit("/shelters/#{shelter_1.id}")
    click_on("Delete Shelter")
    expect(page).to have_content("The shelter can not be deleted due to pending application")
    expect(current_path).to eq("/shelters/#{shelter_1.id}")
  end

  it "Will delete a shelter with pets that have not been approved" do
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

    application1 = Application.create({
      name: "Hambone Fakenamington",
      address: "555 s. Sunset st.",
      city: "Los Angeles",
      state: "CA",
      zip: 55555,
      phone_number: 3459999,
      description: "I want the pet"
    })

    application2 = Application.create({
      name: "Coffee Maker",
      address: "554 s. Sunset st.",
      city: "Albuquerque",
      state: "NM",
      zip: 50555,
      phone_number: 3859999,
      description: "I would like the pet as well."
    })

    PetApplication.create(pet_id: pet_1.id, application_id: application1.id)
    PetApplication.create(pet_id: pet_1.id, application_id: application2.id)

    visit("/shelters/#{shelter_1.id}")
    click_on("Delete Shelter")
    expect(current_path).to eq("/shelters")
  end
end
