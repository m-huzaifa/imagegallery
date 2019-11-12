# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @attachment = Attachment.find(params[:attachment])
  end

  def create
    amount = params[:orders][:amount].to_i
    attachment_amount = params[:attachment_amount].to_i
    attachment_id = params[:attachment_id].to_i
    attachment = Attachment.find_by_id(attachment_id)
    respond_to do |format|
      format.js do
        @amount = amount
        @attachment_amount = attachment_amount
      end
    end
  end
end
