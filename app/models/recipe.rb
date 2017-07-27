class Recipe < ApplicationRecord
  validates :name, :api_id, presence: true
end
