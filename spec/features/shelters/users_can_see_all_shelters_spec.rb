require "rails_helper"

RSpec.describe "Shelters index page", type: :feature do
    it "can see all shelter names" do
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

        visit "/shelters"

        expect(page).to have_content(shelter_1.name)
        expect(page).to have_content(shelter_2.name)
    end
end
