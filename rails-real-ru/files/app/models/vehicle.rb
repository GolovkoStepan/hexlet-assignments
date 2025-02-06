# frozen_string_literal: true

class Vehicle < ApplicationRecord
  # BEGIN
  MAX_IMAGE_SIZE_MB = 5
  # END

  validates :manufacture, presence: true
  validates :model, presence: true
  validates :color, presence: true
  validates :doors, presence: true, numericality: { only_integer: true }
  validates :kilometrage, presence: true, numericality: { only_integer: true }
  validates :production_year, presence: true

  # BEGIN
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [200, 100]
  end

  validates :image,
    attached: true,
    size: { less_than: MAX_IMAGE_SIZE_MB.megabytes },
    content_type: ['image/png', 'image/jpg', 'image/jpeg']
  # END
end
