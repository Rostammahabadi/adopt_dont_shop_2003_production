class FavoritesController < ApplicationController
    def update
        pet = Pet.find(params[:pet_id])
        favorites.add_pet(pet.id)
        session[:favorites] = favorites.contents
        flash[:notice] = "#{pet.name} has been added to favorites."
        redirect_to("/pets/#{pet.id}")
    end

    def destroy
        pet = Pet.find(params[:pet_id])
        favorites.remove_pet(pet.id)
        session[:favorites] = favorites.contents
        flash[:notice] = "#{pet.name} has been removed from favorites."
        redirect_to(request.referrer)
    end

    def index
      @favorite_pets = favorites.contents.uniq.flat_map do |favorite|
        Pet.where("#{favorite} = id")
      end
    end
end
