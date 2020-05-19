require 'rails_helper'

RSpec.describe "Delete review page", type: :feature do
    it "can delete a new review" do

      shelter_1 = Shelter.create( name: "4 Paws Rescue",
                            address: "6567 W Long Dr.",
                            city: "Littleton",
                            state: "CO",
                            zip: "80123")

      review1 = shelter_1.reviews.create(
        title: "Awesome",
        rating: 4,
        content: "This place was amazing, really cared for their animals",
        picture: "url.url"
      )

      review2 = shelter_1.reviews.create(
        title: "Ehh",
        rating: 2,
        content: "Not impressed",
        picture: "url"
      )
    visit("/shelters/#{shelter_1.id}")
    within(".review-#{review1.id}") do
      has_link?("Delete")
      click_link("Delete")
    end
    
    expect(current_path).to eq("/shelters/#{shelter_1.id}")
    expect(page).to_not have_content("Awesome")
    expect(page).to_not have_content("Rating: #{4}")
    expect(page).to_not have_content("This place was amazing,really cared for their animals")
    expect(page).to_not have_content("url.url")
    expect(page).to have_content("Ehh")
    expect(page).to have_content(2)
    expect(page).to have_content("Not impressed")
    end
end
