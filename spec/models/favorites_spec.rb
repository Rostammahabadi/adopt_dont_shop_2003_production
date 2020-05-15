require "rails_helper"

RSpec.describe Favorites do

    it "can create a new favorites object" do
        favorites = Favorites.new([1, 2])

        expect(favorites).to be_kind_of(Favorites)
    end

    it "can calculate total number of favorited pets" do
        favorites = Favorites.new([1, 2])

        expect(favorites.total_count).to eq(2)
    end

    it "can add a pet to favorites that has not yet been favorited" do
        favorites = Favorites.new([])

        favorites.add_pet(1)
        favorites.add_pet(2)

        expect(favorites.contents).to eq([1, 2])
    end

    it "can remove a pet from favorites" do
        favorites = Favorites.new([1, 2, 3])

        expect(favorites.contents).to eq([1, 2, 3])

        favorites.remove_pet(2)

        expect(favorites.contents).to eq([1, 3])
    end

    it "can update a pet that is not in favorites" do
        favorites = Favorites.new([1, 2, 3])

        favorites.update_pet(4)

        expect(favorites.contents).to eq([1, 2, 3, 4])
    end

    it "can update a pet that is not in favorites" do
        favorites = Favorites.new([1, 2, 3])

        favorites.update_pet(3)
        expect(favorites.contents).to eq([1, 2])

        favorites.update_pet(1)
        expect(favorites.contents).to eq([2])
    end
end