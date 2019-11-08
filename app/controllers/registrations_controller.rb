# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  # method for user to update email/username without password confirmation

  protected

  def update_resource(resource, params)
    if params[:password].blank? && params[:password_confirmation].blank?
      resource.update_without_password(params)
    else
      super
    end
   end
end
