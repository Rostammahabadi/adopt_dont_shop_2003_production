class PetApplicationsController < ApplicationController
  def show
    @applications = application
  end

  def update
    @pet_application = PetApplication.find(params[:pet_application_id])
    @pet = @pet_application.pet
    if @pet_application.approved
      @pet_application.update(:approved => false)
      @pet.update(:adoption_status => "Adoptable")
    else
      @pet_application.update(:approved => true)
      @pet.update(:adoption_status => "Pending")
    end
    redirect_to "/pets/#{@pet.id}"
  end

  private

  def pet_application
    PetApplication.where("#{params[:pet_id]} = pet_id")
  end

  def application
    pet_app = pet_application
    pet_app.map do |app|
      Application.where("#{app.application_id} = id")
    end.flatten
  end

end
