class PetApplicationsController < ApplicationController
  def show
    @applications = application
  end

  def update
    @pet_application = PetApplication.find(params[:pet_application_id])
    if @pet_application.approved
      @pet_application.update(:approved => false)
      @pet_application.pet.update(:adoption_status => "Adoptable")
      redirect_to "/applications/#{@pet_application.application_id}"
    else
      @pet_application.update(:approved => true)
      @pet_application.pet.update(:adoption_status => "Pending")
      redirect_to "/pets/#{@pet_application.pet_id}"
    end
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
