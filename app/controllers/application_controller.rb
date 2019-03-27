class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include UsersHelper

private

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
  
  #Confirms a playlist belongs to a user
  def playlist_owner
    @playlist = current_user.playlists.find_by(id: params[:playlist_id])
    redirect_to root_url if @playlist.nil?
end

end
