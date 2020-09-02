require 'rails_helper'

RSpec.describe 'Merchants API' do
  it 'returns a list of items that belong to the merchant' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    item2 = create(:item, merchant_id: merchant.id)
    create_list(:item, 3)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    items_response = JSON.parse(response.body, symbolize_names: true)

    expect(items_response.class).to eq(Hash)
    expect(items_response[:data].length).to eq(2)

    expect(items_response[:data].first).to have_key(:id)
    expect(items_response[:data].first[:id]).to eq("#{item.id}")
    expect(items_response[:data].first).to have_key(:type)
    expect(items_response[:data].first[:type]).to eq('item')
    expect(items_response[:data].first).to have_key(:attributes)
    expect(items_response[:data].first[:attributes]).to have_key(:name)
    expect(items_response[:data].first[:attributes][:name]).to eq(item.name)
    expect(items_response[:data].first[:attributes]).to have_key(:description)
    expect(items_response[:data].first[:attributes][:description]).to eq(item.description)
    expect(items_response[:data].first[:attributes]).to have_key(:unit_price)
    expect(items_response[:data].first[:attributes][:unit_price]).to eq(item.unit_price)
    expect(items_response[:data].first[:attributes]).to have_key(:merchant_id)
    expect(items_response[:data].first[:attributes][:merchant_id]).to eq(item.merchant_id)

    expect(items_response[:data].last).to have_key(:id)
    expect(items_response[:data].last[:id]).to eq("#{item2.id}")
    expect(items_response[:data].last).to have_key(:type)
    expect(items_response[:data].last[:type]).to eq('item')
    expect(items_response[:data].last).to have_key(:attributes)
    expect(items_response[:data].last[:attributes]).to have_key(:name)
    expect(items_response[:data].last[:attributes][:name]).to eq(item2.name)
    expect(items_response[:data].last[:attributes]).to have_key(:description)
    expect(items_response[:data].last[:attributes][:description]).to eq(item2.description)
    expect(items_response[:data].last[:attributes]).to have_key(:unit_price)
    expect(items_response[:data].last[:attributes][:unit_price]).to eq(item2.unit_price)
    expect(items_response[:data].last[:attributes]).to have_key(:merchant_id)
    expect(items_response[:data].last[:attributes][:merchant_id]).to eq(item2.merchant_id)
  end
end
