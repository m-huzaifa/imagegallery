# frozen_string_literal: true

# controller for user actions

class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def index
    @users = User.joins(:roles)
  end

  def show; end

  def new_gallery
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create_gallery
    respond_to do |format|
      if current_user.update(user_params)
        format.html { redirect_to attachments_path, notice: 'Attachments was successfully updated.' }
      else
        format.html { redirect_to attachments_path, alert: 'Attachments could not be added.' }
      end
      format.js
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, { role_ids: [] }, attachments_attributes: %i[id title image_type description price created_by place user_id image_cache remote_image_url image images_cache remove_image amount])
  end
end
