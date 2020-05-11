require 'rails_helper'

describe Shelter, type: :model do
    describe "validations" do
        it {should validate_presence_of :name}
        it {should validate_presence_of :address}
        it {should validate_presence_of :city}
        it {should validate_presence_of :state}
        it {should validate_presence_of :zip}
    end

    describe "relationships" do
        it {should have_many :pets}
        it {should have_many :reviews}
    end

    describe "methods" do
        it "can get adoptable_pets" do
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

            shelter_pets = shelter_1.adoptable_pets

            expect(shelter_pets).to eq([pet_1])
        end
    end
end
