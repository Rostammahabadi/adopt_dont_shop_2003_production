class Pet < ApplicationRecord
    validates_presence_of :name, :image, :description, :age, :sex, :adoption_status
    belongs_to :shelter
    has_many :pet_applications
    has_many :applications, through: :pet_applications

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

    def favorite_action(favorites)
        if favorites.include?(id)
            :delete
        else
            :patch
        end
    end

    def application_link_text
        if adoption_status == "Adoptable"
            "Approve"
        else
            "Unapprove"
        end
    end
end