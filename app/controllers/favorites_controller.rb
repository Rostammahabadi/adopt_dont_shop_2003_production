class FavoritesController < ApplicationController
    def update
        pet = Pet.find(params[:pet_id])
        favorites.add_pet(pet.id)
        session[:favorites] = favorites.contents
        flash[:notice] = "#{pet.name} has been added to favorites."
        redirect_to("/pets/#{pet.id}")
    end

    def index
      if favorites.contents.empty?
        render :no_favorites
      else
        @favorite_pets = favorites.contents.uniq.flat_map do |favorite|
          Pet.where("#{favorite} = id")
        end
      end
    end
end
