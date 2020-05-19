class SheltersController < ApplicationController
    def index
        @shelters = Shelter.all
    end

    def show
        @shelter = Shelter.find(params[:id])
        @reviews = Review.where("? = shelter_id", params[:id])
    end

    def new
    end

    def create
        shelter = Shelter.new(shelter_params)
        if shelter.valid?
            shelter.save
            redirect_to "/shelters"
        else
            flash.now[:notice] = shelter.errors.full_messages.map { |message| message }.join(", ")
            render(:new)
        end
    end

    def edit
        @shelter = Shelter.find(params[:id])
    end

    def update
        shelter = Shelter.find(params[:id])
        shelter.update(shelter_params)
        if shelter.valid?
            shelter.save
            redirect_to "/shelters/#{shelter.id}"
        else
            flash[:notice] = shelter.errors.full_messages.map { |message| message }.join(", ")
            redirect_to "/shelters/#{shelter.id}/edit"
        end
    end

    def destroy
      if approved_or_pending == false
        delete_pets_for_shelter
        delete_pet_applications_for_shelter
        Review.where("? = shelter_id", params[:id]).destroy_all
        Shelter.destroy(params[:id])
        redirect_to "/shelters"
      else
        flash[:notice] = "The shelter can not be deleted due to pending application"
        redirect_to "/shelters/#{params[:id]}"
      end
    end

    private

    def delete_pet_applications_for_shelter
        PetApplication.where("? = pet_id", params[:id]).destroy_all
    end

    def delete_pets_for_shelter
      Pet.where("? = shelter_id", params[:id]).destroy_all
    end

    def approved_or_pending
      status = false
      Shelter.find("#{params[:id]} = id").pets.each do |pet|
        return true if PetApplication.where("? = pet_id AND approved = ?", pet.id, true).empty? == false
        return true if Pet.where("id = ? AND adoption_status = ?", pet.id, "Pending").empty? == false
      end
      status
    end

    def shelter_params
        params.permit(:name, :address, :city, :state, :zip)
    end
end
