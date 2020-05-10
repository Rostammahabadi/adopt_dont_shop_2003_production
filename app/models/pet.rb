class Pet < ApplicationRecord
    validates_presence_of :name, :image, :description, :age, :sex, :adoption_status
    belongs_to :shelter
end