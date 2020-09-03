class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  scope :by_id, -> (value) { where(id: value) }
  scope :by_name, -> (value) { where('lower(name) like ?', "%#{value.downcase}%") }
  scope :by_date, -> (attribute, value) { where("Date(#{attribute}) = ?", value) }

  def self.find_merchant(search_param)
    attribute = search_param.keys.first.to_s
    value = search_param.values.first
    if attribute == 'id'
      by_id(value).first
    elsif attribute == 'name'
      by_name(value).first
    else
      by_date(attribute, value).first
    end
  end

  def self.find_merchants(search_param)
    attribute = search_param.keys.first.to_s
    value = search_param.values.first
    if attribute == 'id'
      by_id(value).first
    elsif attribute == 'name'
      by_name(value)
    else
      by_date(attribute, value)
    end
  end

  def self.highest_revenues(num_merchants)
    joins(invoices: [:invoice_items, :transactions])
      .select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
      .where("transactions.result='success' AND invoices.status='shipped'")
      .group(:id)
      .order('total_revenue DESC')
      .limit(num_merchants)
  end
end
