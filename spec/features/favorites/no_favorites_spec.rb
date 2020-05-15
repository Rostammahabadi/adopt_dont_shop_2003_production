require 'rails_helper'

RSpec.describe "User can see no favorites on page when favorites is zero" do
    it "displays no pets when no favorites" do
        visit("/favorites")
        expect(page).to have_content("You have no favorited pets")
    end
end
