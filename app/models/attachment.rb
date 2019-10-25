class Attachment < ApplicationRecord
	belongs_to :user
	mount_uploader :image, ImageUploader
	
	validates :title, presence: true
	validates :description, presence: true
	validates :image_type, presence: true
	validates :place, presence: true
	validates :price, presence: true, numericality: { only_integer: true }
	validates :created_by, presence: true
	validates :image, presence: true, file_size: { less_than: 1.megabyte }

	def update_attachment_after_order(attachment_amount)
		if self.update(amount: attachment_amount)
			puts "success"
		else
			puts "failed to update amount"
		end
	end

end
