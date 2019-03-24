module UsersHelper
  include SessionsHelper

  def admin_user?
    logged_in? && current_user.admin?
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless admin_user?
  end
end
