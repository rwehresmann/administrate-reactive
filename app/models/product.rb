class Product < ApplicationRecord
  belongs_to :sales_point

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
end
