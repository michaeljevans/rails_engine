require 'rails_helper'

RSpec.describe 'Merchants API' do
  it 'can return a list of merchants with the most revenue' do
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

    get '/api/v1/merchants/most_revenue?quantity=2'

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    revenue_response = JSON.parse(response.body, symbolize_names: true)

    expect(revenue_response.class).to eq(Hash)
    expect(revenue_response[:data].length).to eq(2)
    expect(revenue_response[:data].first).to have_key(:id)
    expect(revenue_response[:data].first[:id]).to eq("#{merchant3.id}")
    expect(revenue_response[:data].first).to have_key(:type)
    expect(revenue_response[:data].first[:type]).to eq('merchant')
    expect(revenue_response[:data].first).to have_key(:attributes)
    expect(revenue_response[:data].first[:attributes]).to have_key(:name)
    expect(revenue_response[:data].first[:attributes][:name]).to eq(merchant3.name)
  end
end
