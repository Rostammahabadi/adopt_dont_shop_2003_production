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
        @button_text = @pet.favorite_text(favorites.contents)
        @button_class = @pet.favorite_class(favorites.contents)
        @button_action = @pet.favorite_action(favorites.contents)
    end

    def new
        @shelter_id = params[:shelter_id]
    end

    def create
        shelter = Shelter.find(params[:shelter_id])
        shelter.pets.create!(pet_params)
        redirect_to "/shelters/#{shelter.id}/pets"
    end

    def edit
        @pet = Pet.find(params[:id])
    end

    def update
        pet = Pet.find(params[:id])
        pet.update(pet_params)
        pet.save
        redirect_to "/pets/#{pet.id}"
    end

    def destroy
        Pet.destroy(params[:id])
        redirect_to "/pets"
    end


    private

    def pet_params
        defaults = {adoption_status: "Adoptable"}
        params.permit(:name, :image, :description, :age, :sex, :adoption_status).reverse_merge(defaults)
    end
end
