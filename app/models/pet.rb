class Pet < ApplicationRecord
    validates_presence_of :name, :image, :description, :age, :sex, :adoption_status
    belongs_to :shelter

    def favorite_text(favorites)
        if favorites.include?(id)
            "Remove from Favorites"
        else
            "Favorite"
        end
    end

    def favorite_class(favorites)
        if favorites.include?(id)
            "remove-favorite"
        else
            "shelter-update-top"
        end
    end
end