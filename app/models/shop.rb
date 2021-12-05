class Shop < ApplicationRecord
  has_many :sales_points

  validates :name, presence: true
end
