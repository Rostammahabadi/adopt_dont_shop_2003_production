class Pet < ApplicationRecord
    validates_presence_of :name, :image, :description, :age, :sex
    belongs_to :shelter
    has_many :pet_applications, dependent: :destroy
    has_many :applications, through: :pet_applications

    before_save :default_values

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

    def default_values
        self.adoption_status ||= 'Adoptable'
    end
end
