class Micropost < ApplicationRecord
	belongs_to :user
	default_scope -> { order(created_at: :desc) }
	mount_uploader :picture, PictureUploader
	validates :user_id, presence: true
	validates :content, length: {maximum: 155}
	validates :picture, presence: true
	validate :picture_size

	private

		# Validates the size of an uploaded image
		def picture_size
			if picture.size > 1.megabytes
				errors.add(:picture, "should be less than 1MB")
			end
		end
end