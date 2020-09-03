class Item < ApplicationRecord
  validates :name, :description, presence: true
  validates :unit_price, numericality: true, presence: true

  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items, dependent: :destroy

  scope :by_id, -> (value) { where(id: value) }
  scope :by_name, -> (value) { where('lower(name) like ?', "%#{value.downcase}%") }
  scope :by_description, -> (value) { where('lower(description) like ?', "%#{value.downcase}%") }
  scope :by_unit_price, -> (value) { where(unit_price: value) }
  scope :by_merchant_id, -> (value) { where(merchant_id: value) }
  scope :by_created_at, -> (value) { where('Date(created_at) = ?', value) }
  scope :by_updated_at, -> (value) { where('Date(updated_at) = ?', value) }

  def self.find_item(search_param)
    attribute = search_param.keys.first.to_s
    value = search_param.values.first
    if attribute == 'id'
      by_id(value).first
    elsif attribute == 'name'
      by_name(value).first
    elsif attribute == 'description'
      by_description(value).first
    elsif attribute == 'unit_price'
      by_unit_price(value).first
    elsif attribute == 'merchant_id'
      by_merchant_id(value).first
    elsif attribute == 'created_at'
      by_created_at(value).first
    else
      by_updated_at(value).first
    end
  end
end
