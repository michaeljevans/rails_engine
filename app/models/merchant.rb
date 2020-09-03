class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy

  scope :by_id, -> (value) { where(id: value) }
  scope :by_name, -> (value) { where('lower(name) like ?', "%#{value.downcase}%") }
  scope :by_created_at, -> (value) { where('Date(created_at) = ?', value) }
  scope :by_updated_at, -> (value) { where('Date(updated_at) = ?', value) }

  def self.find_merchant(search_param)
    attribute = search_param.keys.first.to_s
    value = search_param.values.first
    if attribute == 'id'
      by_id(value).first
    elsif attribute == 'name'
      by_name(value).first
    elsif attribute == 'created_at'
      by_created_at(value).first
    else
      by_updated_at(value).first
    end
  end

  def self.find_merchants(search_param)
    attribute = search_param.keys.first.to_s
    value = search_param.values.first
    if attribute == 'id'
      by_id(value).first
    elsif attribute == 'name'
      by_name(value)
    elsif attribute == 'created_at'
      by_created_at(value)
    else
      by_updated_at(value)
    end
  end
end
