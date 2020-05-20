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
      multiple_pet_apps(new_app)
      delete_applied_pets
      redirect_to "/favorites"
      flash[:notice] = "Your application has been submitted."
    else
      flash[:notice] = "You must fill out all fields"
      redirect_to "/applications/new"
    end
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end

  def multiple_pet_apps(new_app)
    params[:pet_apps].each do |pet|
      new_pet = find_pet_by_name(pet)
      PetApplication.create(pet_id: new_pet.id, application_id: new_app.id)
    end
  end

  def find_pet_by_name(pet)
    Pet.find_by(name:"#{pet}")
  end

  def delete_applied_pets
    params[:pet_apps].each do |pet|
      pet_to_delete = find_pet_by_name(pet)
      favorites.contents.delete(pet_to_delete.id)
    end
  end
end
