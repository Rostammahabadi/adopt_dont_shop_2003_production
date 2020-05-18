require 'rails_helper'

describe Pet, type: :model do
    describe "validations" do
        it {should validate_presence_of :name}
        it {should validate_presence_of :image}
        it {should validate_presence_of :description}
        it {should validate_presence_of :age}
        it {should validate_presence_of :sex}
    end

    describe "relationships" do
        it {should belong_to :shelter}
        it {should have_many :pet_applications}
        it {should have_many(:applications).through((:pet_applications))}
    end

    it "creates an instance of Pet" do
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

        expect(pet_1).to be_kind_of(Pet)
    end

    it "can get the proper favorite_text" do
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
        favorites = Favorites.new([])

        expect(pet_1.favorite_text(favorites.contents)).to eq("Favorite")

        favorites.add_pet(pet_1.id)

        expect(pet_1.favorite_text(favorites.contents)).to eq("Remove from Favorites")
    end

    it "can get the proper favorite_class" do
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
        favorites = Favorites.new([])

        expect(pet_1.favorite_class(favorites.contents)).to eq("shelter-update-top")

        favorites.add_pet(pet_1.id)

        expect(pet_1.favorite_class(favorites.contents)).to eq("remove-favorite")
    end

    it "can get the proper favorite_action" do

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
        favorites = Favorites.new([])

        expect(pet_1.favorite_action(favorites.contents)).to eq(:patch)

        favorites.add_pet(pet_1.id)

        expect(pet_1.favorite_action(favorites.contents)).to eq(:delete)
    end 

    it "can assign default value of adoptable for adoption_status" do
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
                            shelter_id: shelter_1.id)
        
        expect(pet_1.adoption_status).to eq("Adoptable")
    end
end