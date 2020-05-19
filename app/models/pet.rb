class Pet < ApplicationRecord
    validates_presence_of :name, :image, :description, :age, :sex
    belongs_to :shelter
    has_many :pet_applications
    has_many :applications, through: :pet_applications

    before_save :default_values

    def default_values
        self.adoption_status ||= 'Adoptable'
    end
end