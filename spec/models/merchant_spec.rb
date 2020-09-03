require 'rails_helper'

RSpec.describe Merchant do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :invoices }
    it { should have_many(:transactions).through(:invoices) }
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

    it '.find_merchants(search_param)' do
      merchant = Merchant.create(name: 'REI')
      merchant2 = Merchant.create(name: 'Outdoor Goods')
      merchant3 = Merchant.create(name: 'We Got The Goodz')

      expect(Merchant.find_merchants(id: merchant2.id)).to eq(merchant2)
      expect(Merchant.find_merchants(name: 'good')).to eq([merchant2, merchant3])
      expect(Merchant.find_merchants(created_at: merchant.created_at.to_s)).to eq([merchant, merchant2, merchant3])
      expect(Merchant.find_merchants(updated_at: merchant.updated_at.to_s)).to eq([merchant, merchant2, merchant3])
    end

    it '.highest_revenues(num_merchants)' do
      customer = create(:customer)

      merchant = create(:merchant, name: 'The Goodz')
      item = create(:item, merchant_id: merchant.id)

      merchant2 = create(:merchant, name: 'Lotta Stuff')
      item2 = create(:item, merchant_id: merchant2.id)

      merchant3 = create(:merchant, name: 'Holy Guacamole')
      item3 = create(:item, merchant_id: merchant3.id)

      invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
      invoice2 = create(:invoice, customer_id: customer.id, merchant_id: merchant2.id)
      invoice3 = create(:invoice, customer_id: customer.id, merchant_id: merchant3.id)
      invoice4 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)

      create(:invoice_item, invoice_id: invoice.id, item_id: item.id, unit_price: 36.75, quantity: 47)
      create(:invoice_item, invoice_id: invoice2.id, item_id: item2.id, unit_price: 75.10, quantity: 35)
      create(:invoice_item, invoice_id: invoice3.id, item_id: item3.id, unit_price: 124.89, quantity: 31)
      create(:invoice_item, invoice_id: invoice4.id, item_id: item.id, unit_price: 36.75, quantity: 12)

      create(:transaction, invoice_id: invoice.id, result: 'success')
      create(:transaction, invoice_id: invoice2.id, result: 'failed')
      create(:transaction, invoice_id: invoice3.id, result: 'success')
      create(:transaction, invoice_id: invoice4.id, result: 'success')

      expect(Merchant.highest_revenues(2).length).to eq(2)
      expect(Merchant.highest_revenues(2)).to eq([merchant3, merchant])
    end

    it '.most_items_sold(num_merchants)' do
      customer = create(:customer)

      merchant = create(:merchant, name: 'The Goodz')
      item = create(:item, merchant_id: merchant.id)

      merchant2 = create(:merchant, name: 'Lotta Stuff')
      item2 = create(:item, merchant_id: merchant2.id)

      merchant3 = create(:merchant, name: 'Holy Guacamole')
      item3 = create(:item, merchant_id: merchant3.id)

      invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
      invoice2 = create(:invoice, customer_id: customer.id, merchant_id: merchant2.id)
      invoice3 = create(:invoice, customer_id: customer.id, merchant_id: merchant3.id)
      invoice4 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)

      create(:invoice_item, invoice_id: invoice.id, item_id: item.id, unit_price: 36.75, quantity: 21)
      create(:invoice_item, invoice_id: invoice2.id, item_id: item2.id, unit_price: 75.10, quantity: 35)
      create(:invoice_item, invoice_id: invoice3.id, item_id: item3.id, unit_price: 124.89, quantity: 31)
      create(:invoice_item, invoice_id: invoice4.id, item_id: item.id, unit_price: 36.75, quantity: 12)

      create(:transaction, invoice_id: invoice.id, result: 'success')
      create(:transaction, invoice_id: invoice2.id, result: 'success')
      create(:transaction, invoice_id: invoice3.id, result: 'success')
      create(:transaction, invoice_id: invoice4.id, result: 'success')

      expect(Merchant.most_items_sold(2).length).to eq(2)
      expect(Merchant.most_items_sold(2)).to eq([merchant2, merchant])
    end
  end
end
