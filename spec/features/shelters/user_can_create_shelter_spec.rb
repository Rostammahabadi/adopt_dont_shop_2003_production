require 'rails_helper'

RSpec.describe "Create shelter page", type: :feature do
    it "can access shelter creation page" do
        visit '/shelters'
        click_link("New Shelter")

        expect(page).to have_css("new-shelter")
    end
end