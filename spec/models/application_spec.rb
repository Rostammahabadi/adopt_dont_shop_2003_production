require "rails_helper"

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many :pets}
    it { should have_many(:pets).through(:pet_applications)}
  end
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
    it {should validate_presence_of :description}
  end

  it "can get all pets with applications" do
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
    PetApplication.create(pet_id: pet_2.id, application_id: application1.id)

    expect(Application.all_pets).to eq([pet_1, pet_2])
  end
end
