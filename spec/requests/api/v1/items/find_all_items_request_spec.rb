require 'rails_helper'

RSpec.describe 'Items API' do
  it 'can return one item based on id search' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    item2 = create(:item, merchant_id: merchant.id)
    item3 = create(:item, merchant_id: merchant.id)

    merchant2 = create(:merchant)
    item4 = create(:item, merchant_id: merchant2.id)
    item5 = create(:item, merchant_id: merchant2.id)
    item6 = create(:item, merchant_id: merchant2.id)

    get "/api/v1/items/find_all?id=#{item.id}"

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    items_response = JSON.parse(response.body, symbolize_names: true)

    expect(items_response.class).to eq(Hash)
    expect(items_response[:data]).to have_key(:id)
    expect(items_response[:data]).to have_key(:type)
    expect(items_response[:data][:type]).to eq('item')
    expect(items_response[:data]).to have_key(:attributes)
    expect(items_response[:data][:attributes]).to have_key(:name)
    expect(items_response[:data][:attributes]).to have_key(:description)
    expect(items_response[:data][:attributes]).to have_key(:unit_price)
    expect(items_response[:data][:attributes]).to have_key(:merchant_id)
  end

  it 'can return a list of items based on name search' do
    merchant = create(:merchant)
    item = create(:item, name: 'cudgel', merchant_id: merchant.id)
    item2 = create(:item, name: 'bludgeon', merchant_id: merchant.id)
    item3 = create(:item, merchant_id: merchant.id)

    merchant2 = create(:merchant)
    item4 = create(:item, name: 'smudge', merchant_id: merchant2.id)
    item5 = create(:item, merchant_id: merchant2.id)
    item6 = create(:item, merchant_id: merchant2.id)

    get '/api/v1/items/find_all?name=udge'

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    items_response = JSON.parse(response.body, symbolize_names: true)

    expect(items_response.class).to eq(Hash)
    expect(items_response[:data].length).to eq(3)
    expect(items_response[:data].first).to have_key(:id)
    expect(items_response[:data].first).to have_key(:type)
    expect(items_response[:data].first[:type]).to eq('item')
    expect(items_response[:data].first).to have_key(:attributes)
    expect(items_response[:data].first[:attributes]).to have_key(:name)
    expect(items_response[:data].first[:attributes]).to have_key(:description)
    expect(items_response[:data].first[:attributes]).to have_key(:unit_price)
    expect(items_response[:data].first[:attributes]).to have_key(:merchant_id)
  end

  it 'can return a list of items based on description search' do
    merchant = create(:merchant)
    item = create(:item, description: 'for camping', merchant_id: merchant.id)
    item2 = create(:item, description: 'glamping approved', merchant_id: merchant.id)
    item3 = create(:item, merchant_id: merchant.id)

    merchant2 = create(:merchant)
    item4 = create(:item, description: 'for clamping', merchant_id: merchant2.id)
    item5 = create(:item, merchant_id: merchant2.id)
    item6 = create(:item, merchant_id: merchant2.id)

    get '/api/v1/items/find_all?description=amping'

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    items_response = JSON.parse(response.body, symbolize_names: true)

    expect(items_response.class).to eq(Hash)
    expect(items_response[:data].length).to eq(3)
    expect(items_response[:data].first).to have_key(:id)
    expect(items_response[:data].first).to have_key(:type)
    expect(items_response[:data].first[:type]).to eq('item')
    expect(items_response[:data].first).to have_key(:attributes)
    expect(items_response[:data].first[:attributes]).to have_key(:name)
    expect(items_response[:data].first[:attributes]).to have_key(:description)
    expect(items_response[:data].first[:attributes]).to have_key(:unit_price)
    expect(items_response[:data].first[:attributes]).to have_key(:merchant_id)
  end

  it 'can return a list of items based on unit price search' do
    merchant = create(:merchant)
    item = create(:item, unit_price: 83.25, merchant_id: merchant.id)
    item2 = create(:item, merchant_id: merchant.id)
    item3 = create(:item, merchant_id: merchant.id)

    merchant2 = create(:merchant)
    item4 = create(:item, unit_price: 83.25, merchant_id: merchant2.id)
    item5 = create(:item, merchant_id: merchant2.id)
    item6 = create(:item, merchant_id: merchant2.id)

    get '/api/v1/items/find_all?unit_price=83.25'

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    items_response = JSON.parse(response.body, symbolize_names: true)

    expect(items_response.class).to eq(Hash)
    expect(items_response[:data].length).to eq(2)
    expect(items_response[:data].first).to have_key(:id)
    expect(items_response[:data].first).to have_key(:type)
    expect(items_response[:data].first[:type]).to eq('item')
    expect(items_response[:data].first).to have_key(:attributes)
    expect(items_response[:data].first[:attributes]).to have_key(:name)
    expect(items_response[:data].first[:attributes]).to have_key(:description)
    expect(items_response[:data].first[:attributes]).to have_key(:unit_price)
    expect(items_response[:data].first[:attributes]).to have_key(:merchant_id)
  end

  it 'can return a list of items based on merchant id search' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    item2 = create(:item, merchant_id: merchant.id)
    item3 = create(:item, merchant_id: merchant.id)

    merchant2 = create(:merchant)
    item4 = create(:item, merchant_id: merchant2.id)
    item5 = create(:item, merchant_id: merchant2.id)
    item6 = create(:item, merchant_id: merchant2.id)

    get "/api/v1/items/find_all?merchant_id=#{merchant2.id}"

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    items_response = JSON.parse(response.body, symbolize_names: true)

    expect(items_response.class).to eq(Hash)
    expect(items_response[:data].length).to eq(3)
    expect(items_response[:data].first).to have_key(:id)
    expect(items_response[:data].first).to have_key(:type)
    expect(items_response[:data].first[:type]).to eq('item')
    expect(items_response[:data].first).to have_key(:attributes)
    expect(items_response[:data].first[:attributes]).to have_key(:name)
    expect(items_response[:data].first[:attributes]).to have_key(:description)
    expect(items_response[:data].first[:attributes]).to have_key(:unit_price)
    expect(items_response[:data].first[:attributes]).to have_key(:merchant_id)
  end

  it 'can return a list of items based on created date search' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    item2 = create(:item, merchant_id: merchant.id)
    item3 = create(:item, merchant_id: merchant.id)

    merchant2 = create(:merchant)
    item4 = create(:item, merchant_id: merchant2.id)
    item5 = create(:item, merchant_id: merchant2.id)
    item6 = create(:item, merchant_id: merchant2.id)

    get "/api/v1/items/find_all?created_at=#{item.created_at}"

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    items_response = JSON.parse(response.body, symbolize_names: true)

    expect(items_response.class).to eq(Hash)
    expect(items_response[:data].length).to eq(6)
    expect(items_response[:data].first).to have_key(:id)
    expect(items_response[:data].first).to have_key(:type)
    expect(items_response[:data].first[:type]).to eq('item')
    expect(items_response[:data].first).to have_key(:attributes)
    expect(items_response[:data].first[:attributes]).to have_key(:name)
    expect(items_response[:data].first[:attributes]).to have_key(:description)
    expect(items_response[:data].first[:attributes]).to have_key(:unit_price)
    expect(items_response[:data].first[:attributes]).to have_key(:merchant_id)
  end

  it 'can return a list of items based on updated date search' do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    item2 = create(:item, merchant_id: merchant.id)
    item3 = create(:item, merchant_id: merchant.id)

    merchant2 = create(:merchant)
    item4 = create(:item, merchant_id: merchant2.id)
    item5 = create(:item, merchant_id: merchant2.id)
    item6 = create(:item, merchant_id: merchant2.id)

    get "/api/v1/items/find_all?updated_at=#{item.updated_at}"

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    items_response = JSON.parse(response.body, symbolize_names: true)

    expect(items_response.class).to eq(Hash)
    expect(items_response[:data].length).to eq(6)
    expect(items_response[:data].first).to have_key(:id)
    expect(items_response[:data].first).to have_key(:type)
    expect(items_response[:data].first[:type]).to eq('item')
    expect(items_response[:data].first).to have_key(:attributes)
    expect(items_response[:data].first[:attributes]).to have_key(:name)
    expect(items_response[:data].first[:attributes]).to have_key(:description)
    expect(items_response[:data].first[:attributes]).to have_key(:unit_price)
    expect(items_response[:data].first[:attributes]).to have_key(:merchant_id)
  end
end
