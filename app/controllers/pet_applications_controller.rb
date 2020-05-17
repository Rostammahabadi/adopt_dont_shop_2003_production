class PetApplicationsController < ApplicationController
  def show
    @applications = application
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
