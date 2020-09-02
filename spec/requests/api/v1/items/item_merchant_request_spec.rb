require 'rails_helper'

RSpec.describe 'Items API' do
  it 'returns the merchant to whom the item belongs' do
    item = create(:item)
    merchant = item.merchant

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    merchant_response = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_response.class).to eq(Hash)
    expect(merchant_response[:data]).to have_key(:id)
    expect(merchant_response[:data][:id]).to eq("#{merchant.id}")
    expect(merchant_response[:data]).to have_key(:type)
    expect(merchant_response[:data][:type]).to eq('merchant')
    expect(merchant_response[:data]).to have_key(:attributes)
    expect(merchant_response[:data][:attributes]).to have_key(:name)
    expect(merchant_response[:data][:attributes][:name]).to eq(merchant.name)
  end
end
