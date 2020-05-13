require "rails_helper"

RSpec.describe Favorites do
    it "can calculate total number of favorited pets" do
        favorites = Favorites.new({
            1 => 1,
            2 => 1
        })
    expect(favorites.total_count).to eq(2)
    end

    it "can add pets to favorites" do
        favorites = Favorites.new({'1' => 1, '2' => 1})

        favorites.add_pet(1)
        favorites.add_pet(2)

        expect(favorites.contents).to eq({'1' => 2, '2' => 2})
    end

    it "can count each id and returns zero for a new id" do
        favorites = Favorites.new({'1' => 1, '2' => 1})
        
        expect(favorites.count_of(1)).to eq(1)
        expect(favorites.count_of(3)).to eq(0)
    end

    it "can add a pet to favorites that has not yet been favorited" do
        favorites = Favorites.new({})

        favorites.add_pet(1)
        favorites.add_pet(2)

        expect(favorites.contents).to eq({'1' => 1, '2' => 1})
    end
end