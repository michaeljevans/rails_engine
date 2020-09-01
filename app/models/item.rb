class Item < ApplicationRecord
  validates :name, :description, presence: true
  validates :unit_price, numericality: true, presence: true

  belongs_to :merchant
end
