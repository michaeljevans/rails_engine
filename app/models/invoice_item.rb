class InvoiceItem < ApplicationRecord
  validates :quantity, :unit_price, numericality: true

  belongs_to :item
  belongs_to :invoice
end
