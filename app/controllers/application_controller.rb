class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :favorites

  def favorites
    @favorites ||= Favorites.new(session[:favorites])
  end

  before_action :new

  private

  def shelter_id
    @shelter_id = params[:shelter_id]
  end
end
