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
        @approved_application = PetApplication.find_by(pet_id: @pet.id, approved: true)
    end

    def new
        @shelter_id = params[:shelter_id]
    end

    def create
        shelter = Shelter.find(params[:shelter_id])
        new_pet = shelter.pets.new(pet_params)
        if new_pet.valid?
          new_pet.save
          redirect_to "/shelters/#{shelter.id}/pets"
        else
          flash[:notice] = new_pet.errors.full_messages.join(", ")
          redirect_to "/shelters/#{shelter.id}/pets/new"
        end
    end

    def edit
        @pet = Pet.find(params[:id])
    end

    def update
        pet = Pet.find(params[:id])
        pet.update(pet_params)
        if pet.valid?
          pet.save
          redirect_to "/pets/#{pet.id}"
        else
          flash[:notice] = pet.errors.full_messages.join(", ")
          redirect_to "/pets/#{pet.id}/edit"
        end
    end

    def destroy
        Pet.destroy(params[:id])
        redirect_to "/pets"
    end


    private

    def pet_params
        params.permit(:name, :image, :description, :age, :sex, :adoption_status)
    end
end
