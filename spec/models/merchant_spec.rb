require 'rails_helper'

RSpec.describe Merchant do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :invoices }
  end

  describe 'class methods' do
    it '.find_merchant(search_param)' do
      merchant = Merchant.create(name: 'REI')
      merchant2 = Merchant.create(name: 'Outdoor Goods')
      merchant3 = Merchant.create(name: 'We Got The Goodz')

      expect(Merchant.find_merchant(id: merchant.id)).to eq(merchant)
      expect(Merchant.find_merchant(name: 'dOOr')).to eq(merchant2)
      expect(Merchant.find_merchant(created_at: merchant.created_at.to_s)).to eq(merchant)
      expect(Merchant.find_merchant(updated_at: merchant.updated_at.to_s)).to eq(merchant)
    end
  end
end
