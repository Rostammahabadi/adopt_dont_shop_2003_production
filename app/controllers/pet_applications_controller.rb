class PetApplicationsController < ApplicationController
  def show
    @applications = application
  end

  def update
    @pet_application = PetApplication.find(params[:pet_application_id])
    path_start = @pet_application.redirect_path_start
    path_end = @pet_application.redirect_path_end
    approval_status = @pet_application.new_approval_value
    adoption_status = @pet_application.new_adoption_status
    @pet_application.update(:approved => approval_status)
    @pet_application.pet.update(:adoption_status => adoption_status)
    redirect_to "/#{path_start}/#{path_end}"
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
