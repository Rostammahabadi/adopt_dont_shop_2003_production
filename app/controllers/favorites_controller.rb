class FavoritesController < ApplicationController
    def update
      pet = Pet.find(params[:pet_id])
      if favorites.contents.include?(pet.id)
        message = "#{pet.name} has been removed from favorites."
      else
        message = "#{pet.name} has been added to favorites."
      end
      favorites.update_pet(pet.id)
      session[:favorites] = favorites.contents
      flash[:notice] = message
      redirect_to(request.referrer)
    end

    def destroy
      favorites.contents.clear
      redirect_to "/favorites"
    end

    def index
      @favorite_pets = favorites.contents.uniq.flat_map do |favorite|
        Pet.where("#{favorite} = id")
      end
    end
end
