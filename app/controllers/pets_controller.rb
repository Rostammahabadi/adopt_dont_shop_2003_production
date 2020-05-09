class PetsController < ApplicationController
    def index
        @pets = Pet.all
    end

    def shelter_pets
        shelter = Shelter.find(params[:shelter_id])
        @shelter_pets = shelter.adoptable_pets
    end

    def show
        @pet = Pet.find(params[:id])
    end

    def new
        @shelter_id = params[:shelter_id]
    end

    def create
        shelter = Shelter.find(params[:shelter_id])
        shelter.pets.create!(pet_params)
        redirect_to "/shelters/#{shelter.id}/pets"
    end

    private

    def pet_params
        defaults = {adoption_status: "Adoptable"}
        params.permit(:name, :image, :description, :age, :sex, :adoption_status).reverse_merge(defaults)
    end
end