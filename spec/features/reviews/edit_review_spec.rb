require 'rails_helper'

RSpec.describe "Edit a review", type: :feature do
  it "can edit a review for the shelter" do
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
    visit "/shelters/#{shelter1.id}"
    has_link?("Update")
    click_on("Update")
    expect(current_path).to eq("/shelters/#{shelter1.id}/reviews/#{review1.id}/edit")

    page.has_field?('Title', with: "Awesome")
    page.has_field?('Rating', with: 4)
    page.has_field?('content', with: "This place was amazing, really cared for their animals")
    page.has_field?('Picture', with: "url.url")

    fill_in "title", with: ""
    fill_in "title", with: "Great"

    has_link?("Update")
    click_on("Update")

    expect(current_path).to eq("/shelters/#{shelter1.id}")
    expect(page).to have_content("Great")
    expect(page).to have_content(4)
    expect(page).to have_content("This place was amazing, really cared for their animals")
    expect(page).to have_css("img[src*='url.url']")
  end
  it "flashes message when trying to update without title, rating or content" do
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
    visit "/shelters/#{shelter1.id}/reviews/#{review1.id}/edit"
    fill_in "title", with: ''
    click_on("Update")
    expect(page).to have_content("Need to enter title, rating, and review in order to update.")
    expect(current_path).to eq("/shelters/#{shelter1.id}/reviews/#{review1.id}/edit")

    fill_in "content", with: ''
    click_on("Update")
    expect(page).to have_content("Need to enter title, rating, and review in order to update.")
    expect(current_path).to eq("/shelters/#{shelter1.id}/reviews/#{review1.id}/edit")
  end

end
