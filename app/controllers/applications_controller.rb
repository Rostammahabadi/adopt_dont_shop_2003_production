class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:application_id])
  end

  def new
    @selected_favorites = favorites.contents.map{ |favorite| Pet.where("#{favorite}=id")[0].name }
  end

  def create
    new_app = Application.new(application_params)
    if new_app.save
      pet = Pet.find_by(name:"#{params[:pet]}")
      favorites.contents.delete(pet.id)
      redirect_to "/favorites"
      flash[:notice] = "Your application for #{params[:pet]} has been submitted."
    else
      flash[:notice] = "You must fill out all fields"
      redirect_to "/applications/new"
    end
  end
  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
