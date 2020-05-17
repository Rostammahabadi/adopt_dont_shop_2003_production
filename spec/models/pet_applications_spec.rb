require 'rails_helper'

RSpec.describe PetApplication, type: :model do

  describe "relationships" do
    it {should belong_to :pet}
    it {should belong_to :application}
  end

  it "has default value of false for approved attribute" do
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

    pet_app = PetApplication.create(pet_id: pet_1.id, application_id: application1.id)

    expect(pet_app.approved).to eq(false)
  end

  it "can get proper link_text and link_class" do
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

    pet_app = PetApplication.create(pet_id: pet_1.id, application_id: application1.id)
    pet_app2 = PetApplication.create(pet_id: pet_2.id, application_id: application1.id, approved: true)

    expect(pet_app.link_text).to eq("Approve")
    expect(pet_app.link_class).to eq("shelter-update-top")

    expect(pet_app2.link_text).to eq("Unapprove")
    expect(pet_app2.link_class).to eq("remove-favorite")
  end

  it "can get new_adoption_status and new_approval_value" do
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

    pet_app = PetApplication.create(pet_id: pet_1.id, application_id: application1.id)
    pet_app2 = PetApplication.create(pet_id: pet_2.id, application_id: application1.id, approved: true)

    expect(pet_app.new_approval_value).to eq(true)

    expect(pet_app2.new_approval_value).to eq(false)

    expect(pet_app.new_adoption_status).to eq("Pending")

    expect(pet_app2.new_adoption_status).to eq("Adoptable")
  end
end
