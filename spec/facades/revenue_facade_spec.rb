require 'rails_helper'

RSpec.describe RevenueFacade do
  describe 'class methods' do
    it '.revenue_in_interval(dates)' do
      customer = create(:customer)

      merchant = create(:merchant, name: 'The Goodz')
      item = create(:item, merchant_id: merchant.id)

      merchant2 = create(:merchant, name: 'Lotta Stuff')
      item2 = create(:item, merchant_id: merchant2.id)

      merchant3 = create(:merchant, name: 'Holy Guacamole')
      item3 = create(:item, merchant_id: merchant3.id)

      invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id, status: 'shipped', updated_at: '2020-08-27 12:24:37 UTC')
      invoice2 = create(:invoice, customer_id: customer.id, merchant_id: merchant2.id, status: 'shipped', updated_at: '2020-08-22 16:35:24 UTC')
      invoice3 = create(:invoice, customer_id: customer.id, merchant_id: merchant3.id, status: 'shipped', updated_at: '2020-09-01 20:44:13 UTC')
      invoice4 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id, status: 'pending', updated_at: '2020-08-24 01:25:47 UTC')

      create(:invoice_item, invoice_id: invoice.id, item_id: item.id, unit_price: 36.75, quantity: 47)
      create(:invoice_item, invoice_id: invoice2.id, item_id: item2.id, unit_price: 75.10, quantity: 35)
      create(:invoice_item, invoice_id: invoice3.id, item_id: item3.id, unit_price: 124.89, quantity: 31)
      create(:invoice_item, invoice_id: invoice4.id, item_id: item.id, unit_price: 36.75, quantity: 12)

      create(:transaction, invoice_id: invoice.id, result: 'success')
      create(:transaction, invoice_id: invoice2.id, result: 'success')
      create(:transaction, invoice_id: invoice3.id, result: 'success')
      create(:transaction, invoice_id: invoice4.id, result: 'success')

      dates = {start: '2020-08-21', end: '2020-08-29'}
      result = RevenueFacade.revenue_in_interval(dates)

      expect(result).to be_a(Revenue)
      expect(result.revenue).to eq(4355.75)
    end

    it '.total_merchant_revenue(merchant_id)' do
      customer = create(:customer)

      merchant = create(:merchant, name: 'The Goodz')
      item = create(:item, merchant_id: merchant.id)

      merchant2 = create(:merchant, name: 'Lotta Stuff')
      item2 = create(:item, merchant_id: merchant2.id)

      merchant3 = create(:merchant, name: 'Holy Guacamole')
      item3 = create(:item, merchant_id: merchant3.id)

      invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id, status: 'shipped', updated_at: '2020-08-27 12:24:37 UTC')
      invoice2 = create(:invoice, customer_id: customer.id, merchant_id: merchant2.id, status: 'shipped', updated_at: '2020-08-22 16:35:24 UTC')
      invoice3 = create(:invoice, customer_id: customer.id, merchant_id: merchant3.id, status: 'shipped', updated_at: '2020-09-01 20:44:13 UTC')
      invoice4 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id, status: 'pending', updated_at: '2020-08-24 01:25:47 UTC')

      create(:invoice_item, invoice_id: invoice.id, item_id: item.id, unit_price: 36.75, quantity: 47)
      create(:invoice_item, invoice_id: invoice2.id, item_id: item2.id, unit_price: 75.10, quantity: 35)
      create(:invoice_item, invoice_id: invoice3.id, item_id: item3.id, unit_price: 124.89, quantity: 31)
      create(:invoice_item, invoice_id: invoice4.id, item_id: item.id, unit_price: 36.75, quantity: 12)

      create(:transaction, invoice_id: invoice.id, result: 'success')
      create(:transaction, invoice_id: invoice2.id, result: 'success')
      create(:transaction, invoice_id: invoice3.id, result: 'success')
      create(:transaction, invoice_id: invoice4.id, result: 'success')

      result = RevenueFacade.total_merchant_revenue(merchant.id)

      expect(result).to be_a(Revenue)
      expect(result.revenue).to eq(1727.25)
    end
  end
end
