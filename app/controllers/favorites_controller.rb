class FavoritesController < ApplicationController
    def update
        pet = Pet.find(params[:pet_id])
        pet_id_string = pet.id.to_s
        @favorites = Favorites.new(session[:favorites])
        @favorites.add_pet(pet.id)
        session[:favorites] = @favorites.contents
        flash[:notice] = "#{pet.name} has been added to favorites."
        redirect_to("/pets/#{pet.id}")
    end
end