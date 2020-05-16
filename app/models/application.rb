class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip
  validates_presence_of :description

  def self.all_pets
    pets_applied = all.flat_map {|application| application.pets }
    pets_applied.flatten.uniq
  end
end
