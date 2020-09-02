require 'rails_helper'

RSpec.describe 'Items API' do
  it 'returns a list of all items' do
    create_list(:item, 9)

    get '/api/v1/items'

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    items_response = JSON.parse(response.body, symbolize_names: true)

    expect(items_response.class).to eq(Hash)
    expect(items_response[:data].length).to eq(9)
    expect(items_response[:data].first).to have_key(:id)
    expect(items_response[:data].first).to have_key(:type)
    expect(items_response[:data].first).to have_key(:attributes)
    expect(items_response[:data].first[:attributes]).to have_key(:name)
    expect(items_response[:data].first[:attributes]).to have_key(:description)
    expect(items_response[:data].first[:attributes]).to have_key(:unit_price)
    expect(items_response[:data].first[:attributes]).to have_key(:merchant_id)
  end

  it 'returns one item by its id' do
    item = create(:item)
    id = item.id

    get "/api/v1/items/#{id}"

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    item_response = JSON.parse(response.body, symbolize_names: true)

    expect(item_response.class).to eq(Hash)
    expect(item_response[:data][:id]).to eq("#{id}")
    expect(item_response[:data][:type]).to eq('item')
    expect(item_response[:data][:attributes][:name]).to eq(item.name)
    expect(item_response[:data][:attributes][:description]).to eq(item.description)
    expect(item_response[:data][:attributes][:unit_price]).to eq(item.unit_price)
    expect(item_response[:data][:attributes][:merchant_id]).to eq(item.merchant_id)
  end

  it 'can create a new item' do
    merchant = create(:merchant)

    headers = { 'CONTENT_TYPE': 'application/json' }
    item_params = { name: Faker::Commerce.product_name,
                    description: Faker::Marketing.buzzwords,
                    unit_price: Faker::Number.decimal(l_digits: 3, r_digits: 2),
                    merchant_id: merchant.id
                  }

    post '/api/v1/items',
      headers: headers,
      params: JSON.generate(item_params)

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    item_response = JSON.parse(response.body, symbolize_names: true)

    item = Item.last

    expect(item_response.class).to eq(Hash)
    expect(item_response[:data][:id]).to eq("#{item.id}")
    expect(item_response[:data][:type]).to eq('item')
    expect(item_response[:data][:attributes][:name]).to eq(item.name)
    expect(item_response[:data][:attributes][:description]).to eq(item.description)
    expect(item_response[:data][:attributes][:unit_price]).to eq(item.unit_price)
    expect(item_response[:data][:attributes][:merchant_id]).to eq(item.merchant_id)
  end

  it 'can update an existing item' do
    merchant = create(:merchant)

    id = create(:item).id
    item = Item.last
    name = item.name
    description = item.description
    unit_price = item.unit_price
    merchant_id = item.merchant_id

    headers = { 'CONTENT_TYPE': 'application/json' }
    item_params = { name: 'Jabroni',
                    description: 'you know what to do',
                    unit_price: 23.34,
                    merchant_id: merchant.id
                  }

    patch "/api/v1/items/#{id}",
      headers: headers,
      params: JSON.generate(item_params)

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    item_response = JSON.parse(response.body, symbolize_names: true)

    expect(item_response.class).to eq(Hash)
    expect(item_response[:data][:id]).to eq("#{id}")
    expect(item_response[:data][:type]).to eq('item')
    expect(item_response[:data][:attributes][:name]).to eq(item_params[:name])
    expect(item_response[:data][:attributes][:description]).to eq(item_params[:description])
    expect(item_response[:data][:attributes][:unit_price]).to eq(item_params[:unit_price])
    expect(item_response[:data][:attributes][:merchant_id]).to eq(item_params[:merchant_id])

    item = Item.find_by(id: id)

    expect(item.name).to_not eq(name)
    expect(item.description).to_not eq(description)
    expect(item.unit_price).to_not eq(unit_price)
    expect(item.merchant_id).to_not eq(merchant_id)

    expect(item.name).to eq('Jabroni')
    expect(item.description).to eq('you know what to do')
    expect(item.unit_price).to eq(23.34)
    expect(item.merchant_id).to eq(merchant.id)
  end

  it 'can destroy an existing item' do
    item = create(:item)

    expect(Item.count).to eq(1)

    expect{ delete "/api/v1/items/#{item.id}" }.to change(Item, :count).by(-1)

    expect(response).to be_successful
    expect(response.status).to eq(204)

    expect(Item.count).to eq(0)
    expect{ Item.find(item.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
