# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Review.create(title: "great", rating: 4, content: "Place was great", picture:"test")
shelter_1 = Shelter.create( name:"4 Paws Rescue",address:"6567 W Long Dr.",city:"Littleton",state:"CO",zip:"80123")
pet_1 = Pet.create( name:    "Teddy",
                            image: "https://i.pinimg.com/originals/47/4e/7d/474e7d2479512428a1a4716d5d1656eb.jpg",
                            age:    "10",
                            sex:   "M",
                            description: "A sweet dog looking for a loving home",
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

PetApplication.create(pet_id: pet_1.id, application_id: application1.id, approved: false)
PetApplication.create(pet_id: pet_1.id, application_id: application2.id, approved: false)
