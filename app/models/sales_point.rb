class SalesPoint < ApplicationRecord
  belongs_to :shop
  has_many :products

  validates :address_line1, presence: true
end
