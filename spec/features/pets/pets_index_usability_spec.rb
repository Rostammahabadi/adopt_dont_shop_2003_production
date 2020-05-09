require 'rails_helper'

describe "When I visit the pet index or shelter pets Page", type: :feature do
    it "has links to update next to the pets" do

        shelter_1 = Shelter.create( name: "4 Paws Rescue",
            address: "6567 W Long Dr.",
            city: "Littleton",
            state: "CO",
            zip: "80123")

        pet_1 = Pet.create( name:    "Teddy",
                            image: "https://i.pinimg.com/originals/47/4e/7d/474e7d2479512428a1a4716d5d1656eb.jpg",
                            age:    "10",
                            sex:   "M",
                            description: "A sweet dog looking for a loving home",
                            shelter_id: shelter_1.id,
                            adoption_status: "Adoptable")

        visit "/pets"
        expect(page).to have_content("#{pet_1.name}")

        click_link "Update"
        expect(current_path).to eq("/pets/#{pet_1.id}/edit")

        visit "/shelters/#{shelter_1.id}/pets"

        click_link "Update"
        expect(current_path).to eq("/pets/#{pet_1.id}/edit")
    end

    it "has links to delete next to pets on the pets index page" do
        shelter_1 = Shelter.create( name: "4 Paws Rescue",
                    address: "6567 W Long Dr.",
                    city: "Littleton",
                    state: "CO",
                    zip: "80123")

        pet_1 = Pet.create( name:    "Teddy",
                            image: "https://i.pinimg.com/originals/47/4e/7d/474e7d2479512428a1a4716d5d1656eb.jpg",
                            age:    "10",
                            sex:   "M",
                            description: "A sweet dog looking for a loving home",
                            shelter_id: shelter_1.id,
                            adoption_status: "Adoptable")

        visit "/pets"
        expect(page).to have_content("#{pet_1.name}")

        click_link "Delete"
        expect(current_path).to eq("/pets")
        expect(page).to_not have_content("#{pet_1.name}")
    end

        it "has links to delete next to pets on the shelter pets page" do
        shelter_1 = Shelter.create( name: "4 Paws Rescue",
                    address: "6567 W Long Dr.",
                    city: "Littleton",
                    state: "CO",
                    zip: "80123")

        pet_1 = Pet.create( name:    "Teddy",
                            image: "https://i.pinimg.com/originals/47/4e/7d/474e7d2479512428a1a4716d5d1656eb.jpg",
                            age:    "10",
                            sex:   "M",
                            description: "A sweet dog looking for a loving home",
                            shelter_id: shelter_1.id,
                            adoption_status: "Adoptable")

        visit "/shelters/#{shelter_1.id}/pets"
        expect(page).to have_content("#{pet_1.name}")

        click_link "Delete"
        expect(current_path).to eq("/pets")
        expect(page).to_not have_content("#{pet_1.name}")
    end

    it "has links for shelter names" do
        shelter_1 = Shelter.create( name: "4 Paws Rescue",
                    address: "6567 W Long Dr.",
                    city: "Littleton",
                    state: "CO",
                    zip: "80123")

        pet_1 = Pet.create( name:    "Teddy",
                            image: "https://i.pinimg.com/originals/47/4e/7d/474e7d2479512428a1a4716d5d1656eb.jpg",
                            age:    "10",
                            sex:   "M",
                            description: "A sweet dog looking for a loving home",
                            shelter_id: shelter_1.id,
                            adoption_status: "Adoptable")
        
        visit("/pets")

        click_link("#{pet_1.shelter.name}")
        expect(current_path).to eq("/shelters/#{shelter_1.id}")
    end
end