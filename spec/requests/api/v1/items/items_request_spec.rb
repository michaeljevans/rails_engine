require 'rails_helper'

RSpec.describe 'Items API' do
  it 'returns a list of all items' do
    create_list(:item, 9)

    get '/api/v1/items'

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items.length).to eq(9)
  end

  it 'returns one item by its id' do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    item = JSON.parse(response.body, symbolize_names: true)

    expect(item[:id]).to eq(id)
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
      params: JSON.generate({ item: item_params })

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    item = Item.last

    expect(item.name).to eq(item_params[:name])
    expect(item.description).to eq(item_params[:description])
    expect(item.unit_price).to eq(item_params[:unit_price])
    expect(item.merchant_id).to eq(item_params[:merchant_id])
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
      params: JSON.generate({ item: item_params })

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

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

    expect(Item.count).to eq(0)
    expect{ Item.find(item.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
