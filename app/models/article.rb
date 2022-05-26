# frozen_string_literal: true

# Article's Template
class Article < ApplicationRecord
  has_many :comments

  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100] # thumbnail size
  end

  validates :body,
            presence: true,
            length: {
              maximum: 140,
              minimum: 3
            },
            uniqueness: false

  validates :title,
            presence: true,
            length: {
              maximum: 20,
              minimum: 3
            },
            uniqueness: true

  validate :image_type

  private

  # check if image file pass validation
  def image_type
    is_image_attached = image.attached?
    is_valid_image = !image.content_type.in?(%w[image/jpeg image/png image/gif])
    errors.add(:image, '(png|jpg|gif) only') if is_image_attached && is_valid_image
  end
end
