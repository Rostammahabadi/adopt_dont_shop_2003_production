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
        pet = Pet.find(params[:id])
        if pet.pet_applications.any? {|application| application.approved }
            flash[:notice] = "This pet cannot be deleted due to approved applications"
            redirect_to request.referrer
        else
            pet.pet_applications.each {|pet_app| PetApplication.destroy(pet_app.id) }
            Pet.destroy(pet.id)
            favorites.remove_pet(pet.id)
            redirect_to "/pets"
        end
    end


    private

    def pet_params
        params.permit(:name, :image, :description, :age, :sex, :adoption_status)
    end
end
