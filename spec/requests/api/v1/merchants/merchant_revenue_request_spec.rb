require 'rails_helper'

RSpec.describe 'Merchants API' do
  it 'can return total revenue for a given merchant' do
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

    get "/api/v1/merchants/#{merchant.id}/revenue"

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    merchant_revenue_response = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_revenue_response.class).to eq(Hash)
    expect(merchant_revenue_response[:data]).to have_key(:id)
    expect(merchant_revenue_response[:data][:id]).to eq(nil)
    expect(merchant_revenue_response[:data]).to have_key(:attributes)
    expect(merchant_revenue_response[:data][:attributes]).to have_key(:revenue)
    expect(merchant_revenue_response[:data][:attributes][:revenue]).to eq(1727.25)
  end
end
