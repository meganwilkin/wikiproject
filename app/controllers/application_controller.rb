class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit

  private

   def require_sign_in
     unless current_user
       flash[:alert] = "You must be logged in to do that"
       redirect_to new_session_path
     end
   end

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def update_user_to_premium
    current_user.update_attributes(role: :premium)
  end

  def downgrade_user_to_standard
    current_user.update_attributes(role: :standard)
  end

  def current_user_downgrade_wikis
    privatewikis = current_user.wikis.where(private: true)
    privatewikis.each do |wiki|
      wiki.update_attribute(private: false)
    end
  end


end
