# frozen_string_literal: true

class Task < ApplicationRecord
  validates :name, :creator, presence: true
end
