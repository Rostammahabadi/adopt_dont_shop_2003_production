require 'rails_helper'

RSpec.describe "New review page", type: :feature do
    it "can create a new review" do

        shelter_1 = Shelter.create( name: "4 Paws Rescue",
                            address: "6567 W Long Dr.",
                            city: "Littleton",
                            state: "CO",
                            zip: "80123")

        visit "/shelters/#{shelter_1.id}"
        has_link?("Write a Review")
        click_link("Write a Review")
        expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")

        find_field(:title)
        fill_in :title, with: "Great Shelter"
        find_field(:rating)
        select('5', from: :rating)
        find_field(:content)
        fill_in :content, with: "Very clean place with happy pets."
        find_field(:picture)

        click_on "Submit"
        expect(current_path).to eq("/shelters/#{shelter_1.id}")
        expect(page).to have_content("Great Shelter")
        expect(page).to have_content("5")
        expect(page).to have_content("Very clean place with happy pets.")
    end

    it "can create a review with an optional picture" do
            
        
        shelter_1 = Shelter.create( name: "4 Paws Rescue",
                            address: "6567 W Long Dr.",
                            city: "Littleton",
                            state: "CO",
                            zip: "80123")

        visit "/shelters/#{shelter_1.id}"
        has_link?("Write a Review")
        click_link("Write a Review")
        expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")

        find_field(:title)
        fill_in :title, with: "Great Shelter"
        find_field(:rating)
        select('5', from: :rating)
        find_field(:content)
        fill_in :content, with: "Very clean place with happy pets."
        find_field(:picture)
        fill_in :picture, with: "url.url"

        click_on "Submit"
        expect(current_path).to eq("/shelters/#{shelter_1.id}")
        expect(page).to have_content("Great Shelter")
        expect(page).to have_content("5")
        expect(page).to have_content("Very clean place with happy pets.")
        expect(page).to have_css("img[src*='url.url']")
    end
    it "will not create a review if required fields are missing" do	
        shelter_1 = Shelter.create( name: "4 Paws Rescue",	
                            address: "6567 W Long Dr.",	
                            city: "Littleton",	
                            state: "CO",	
                            zip: "80123")	
        visit "/shelters/#{shelter_1.id}"	
        click_link("Write a Review")	
        expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")	

        fill_in :title, with: "Great Shelter"	
        select('5', from: :rating)
        click_button "Submit"	

        expect(page).to have_content("Review not posted: You must fill in the Title, Rating, and Content in order to post a review.")	
        expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")	
    end
end
