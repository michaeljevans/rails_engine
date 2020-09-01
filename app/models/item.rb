class Item < ApplicationRecord
  validates :name, :description, presence: true
  validates :unit_price, numericality: true, presence: true

  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items, dependent: :destroy
end
