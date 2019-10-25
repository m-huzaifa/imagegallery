class AttachmentsController < ApplicationController
load_and_authorize_resource
before_filter :authenticate_user!, except: [:all_attachments, :show]

	def index
		@attachments = current_user.attachments
	end

	def all_attachments
		@users = User.all
	end

	def gallery
		@user = Attachment.select(:user_id).where(id: params[:id])
		@attachments = Attachment.where(user_id: @user)
	end

	def show
		@attachment = Attachment.find(params[:id])
	end

	def new
		@attachment = Attachment.new
	end

	def edit
		@attachment = Attachment.find(params[:id])
	end

	def create
		@attachment = current_user.attachments.create(attachment_params)
		respond_to do |format|
      	if @attachment.save
        # TODO: Move hardcode flash message into language file
        	format.html { redirect_to user_create_gallery_path(current_user), notice: 'Attachment was successfully added.'}
      	else
        	format.html { redirect_to user_create_gallery_path(current_user), alert: 'Attachments could not be added.' }
      	end
    	end
	end

	def update
		@attachment = Attachment.find(params[:id])
		respond_to do |format|
		if @attachment.update(attachment_params)
        # TODO: Move hardcode flash message into language file
        	format.html { redirect_to attachment_path(@attachment), notice: 'Attachment was successfully updated.'}
      	else
        	format.html { render :edit, alert: 'Attachments could not be updated.' }
      	end
    	end
	end

	def destroy
		@attachment = current_user.attachments.find(params[:id])
		@attachment.destroy

		redirect_to attachments_path
	end

	private def attachment_params
		params.require(:attachment).permit(:title, :image_type, :description, :price, :created_by, :place, :user_id, :image_cache, :remote_image_url, :image, :images_cache, :remove_image)
	end


end
