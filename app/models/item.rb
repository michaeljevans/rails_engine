class Item < ApplicationRecord
  validates :name, :description, presence: true
  validates :unit_price, numericality: true, presence: true

  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items, dependent: :destroy

  scope :by_id, -> (value) { where(id: value) }
  scope :by_name_or_description, -> (attribute, value) { where("lower(#{attribute}) like ?", "%#{value.downcase}%")}
  scope :by_unit_price_or_merchant_id, -> (attribute, value) { where("#{attribute}": value) }
  scope :by_date, -> (attribute, value) { where("Date(#{attribute}) = ?", value)}

  def self.find_item(search_param)
    attribute = search_param.keys.first.to_s
    value = search_param.values.first
    if attribute == 'id'
      by_id(value).first
    elsif attribute == 'unit_price' || attribute == 'merchant_id'
      by_unit_price_or_merchant_id(attribute, value).first
    elsif attribute == 'name' || attribute == 'description'
      by_name_or_description(attribute, value).first
    else
      by_date(attribute, value).first
    end
  end

  def self.find_items(search_param)
    attribute = search_param.keys.first.to_s
    value = search_param.values.first
    if attribute == 'id'
      by_id(value).first
    elsif attribute == 'unit_price' || attribute == 'merchant_id'
      by_unit_price_or_merchant_id(attribute, value)
    elsif attribute == 'name' || attribute == 'description'
      by_name_or_description(attribute, value)
    else
      by_date(attribute, value)
    end
  end
end
