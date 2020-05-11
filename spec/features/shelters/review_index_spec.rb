require 'rails_helper'

RSpec.describe "See a list of reviews for specific shelter", type: :feature do
  it "can show all reviews for the shelter" do
    shelter1 = Shelter.create(
      name: "Puppies",
      address: "123 west street",
      city: "Scottsdale",
      state: "AZ",
      zip: 85257
    )
    review1 = shelter1.reviews.create(
      title: "Awesome",
      rating: 4,
      content: "This place was amazing, really cared for their animals",
      picture: "url.url"
    )
    review2 = shelter1.reviews.create(
      title: "Sweet",
      rating: 3,
      content: "Cool place"
    )
    visit "/shelters/#{shelter1.id}"
    expect(page).to have_content("Awesome")
    expect(page).to have_content(4)
    expect(page).to have_content("This place was amazing, really cared for their animals")
    expect(page).to have_content("url.url")

    expect(page).to have_content("Sweet")
    expect(page).to have_content(3)
    expect(page).to have_content("Cool place")
  end

end
