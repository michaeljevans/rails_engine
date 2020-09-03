require 'rails_helper'

RSpec.describe Item do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_numericality_of :unit_price }
  end

  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'class methods' do
    it '.find_item(search_param)' do
      merchant = Merchant.create(name: 'REI')
      item = Item.create(name: 'tent', description: 'for sleeping outside', unit_price: 87.91, merchant_id: merchant.id)
      item2 = Item.create(name: 'fishing pole', description: "anglin'", unit_price: 99.25, merchant_id: merchant.id)

      merchant2 = Merchant.create(name: 'Outdoor Goods')
      item3 = Item.create(name: 'hiking boots', description: 'for long walks', unit_price: 120.21, merchant_id: merchant2.id)

      expect(Item.find_item(id: item.id)).to eq(item)
      expect(Item.find_item(name: 'g po')).to eq(item2)
      expect(Item.find_item(description: 'ng wa')).to eq(item3)
      expect(Item.find_item(unit_price: 99.25)).to eq(item2)
      expect(Item.find_item(merchant_id: merchant2.id)).to eq(item3)
      expect(Item.find_item(created_at: item.created_at.to_s)).to eq(item)
      expect(Item.find_item(updated_at: item.updated_at.to_s)).to eq(item)
    end

    it '.find_items(search_param)' do
      merchant = Merchant.create(name: 'REI')
      item = Item.create(name: 'tent', description: 'for sleeping outside', unit_price: 87.91, merchant_id: merchant.id)
      item2 = Item.create(name: 'fishing pole', description: "anglin'", unit_price: 99.25, merchant_id: merchant.id)

      merchant2 = Merchant.create(name: 'Outdoor Goods')
      item3 = Item.create(name: 'hiking boots', description: 'long walks', unit_price: 120.21, merchant_id: merchant2.id)
      item4 = Item.create(name: 'walking stick', description: 'for balance', unit_price: 87.91, merchant_id: merchant2.id)

      expect(Item.find_items(id: item.id)).to eq(item)
      expect(Item.find_items(name: 'ing')).to eq([item2, item3, item4])
      expect(Item.find_items(description: 'for ')).to eq([item, item4])
      expect(Item.find_items(unit_price: 87.91)).to eq([item, item4])
      expect(Item.find_items(merchant_id: merchant2.id)).to eq([item3, item4])
      expect(Item.find_items(created_at: item.created_at.to_s)).to eq([item, item2, item3, item4])
      expect(Item.find_items(updated_at: item.updated_at.to_s)).to eq([item, item2, item3, item4])
    end
  end
end
