class SheltersController < ApplicationController
    def index
        @shelters = Shelter.all
    end

    def show
        @shelter = Shelter.find(params[:id])
        @reviews = Review.where("#{params[:id]} = shelter_id")
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
        shelter.save
        redirect_to "/shelters/#{shelter.id}"
    end

    def destroy
      Pet.where("#{params[:id]} = shelter_id").destroy_all
      Review.where("#{params[:id]} = shelter_id").destroy_all
      Shelter.destroy(params[:id])
      redirect_to "/shelters"
    end

    private

    def shelter_params
        params.permit(:name, :address, :city, :state, :zip)
    end
end
