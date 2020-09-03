require 'rails_helper'

RSpec.describe 'Items API' do
  it 'can return an item based on id search' do
    create_list(:item, 9)
    item = Item.last

    get "/api/v1/items/find?id=#{item.id}"

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    item_response = JSON.parse(response.body, symbolize_names: true)

    expect(item_response.class).to eq(Hash)
    expect(item_response.length).to eq(1)
    expect(item_response[:data]).to have_key(:id)
    expect(item_response[:data][:id]).to eq("#{item.id}")
    expect(item_response[:data]).to have_key(:type)
    expect(item_response[:data][:type]).to eq('item')
    expect(item_response[:data]).to have_key(:attributes)
    expect(item_response[:data][:attributes]).to have_key(:name)
    expect(item_response[:data][:attributes][:name]).to eq(item.name)
    expect(item_response[:data][:attributes]).to have_key(:description)
    expect(item_response[:data][:attributes][:description]).to eq(item.description)
    expect(item_response[:data][:attributes]).to have_key(:unit_price)
    expect(item_response[:data][:attributes][:unit_price]).to eq(item.unit_price)
    expect(item_response[:data][:attributes]).to have_key(:merchant_id)
    expect(item_response[:data][:attributes][:merchant_id]).to eq(item.merchant_id)
  end

  it 'can return an item based on name search' do
    create_list(:item, 9)
    item = Item.last

    get "/api/v1/items/find?name=#{item.name[3..9]}"

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    item_response = JSON.parse(response.body, symbolize_names: true)

    expect(item_response.class).to eq(Hash)
    expect(item_response.length).to eq(1)
    expect(item_response[:data]).to have_key(:id)
    expect(item_response[:data][:id]).to eq("#{item.id}")
    expect(item_response[:data]).to have_key(:type)
    expect(item_response[:data][:type]).to eq('item')
    expect(item_response[:data]).to have_key(:attributes)
    expect(item_response[:data][:attributes]).to have_key(:name)
    expect(item_response[:data][:attributes][:name]).to eq(item.name)
    expect(item_response[:data][:attributes]).to have_key(:description)
    expect(item_response[:data][:attributes][:description]).to eq(item.description)
    expect(item_response[:data][:attributes]).to have_key(:unit_price)
    expect(item_response[:data][:attributes][:unit_price]).to eq(item.unit_price)
    expect(item_response[:data][:attributes]).to have_key(:merchant_id)
    expect(item_response[:data][:attributes][:merchant_id]).to eq(item.merchant_id)
  end

  it 'can return an item based on description search' do
    create_list(:item, 9)
    item = Item.last

    get "/api/v1/items/find?description=#{item.description[3..9]}"

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    item_response = JSON.parse(response.body, symbolize_names: true)

    expect(item_response.class).to eq(Hash)
    expect(item_response.length).to eq(1)
    expect(item_response[:data]).to have_key(:id)
    expect(item_response[:data][:id]).to eq("#{item.id}")
    expect(item_response[:data]).to have_key(:type)
    expect(item_response[:data][:type]).to eq('item')
    expect(item_response[:data]).to have_key(:attributes)
    expect(item_response[:data][:attributes]).to have_key(:name)
    expect(item_response[:data][:attributes][:name]).to eq(item.name)
    expect(item_response[:data][:attributes]).to have_key(:description)
    expect(item_response[:data][:attributes][:description]).to eq(item.description)
    expect(item_response[:data][:attributes]).to have_key(:unit_price)
    expect(item_response[:data][:attributes][:unit_price]).to eq(item.unit_price)
    expect(item_response[:data][:attributes]).to have_key(:merchant_id)
    expect(item_response[:data][:attributes][:merchant_id]).to eq(item.merchant_id)
  end

  it 'can return an item based on unit price search' do
    create_list(:item, 9)
    item = Item.last

    get "/api/v1/items/find?unit_price=#{item.unit_price}"

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    item_response = JSON.parse(response.body, symbolize_names: true)

    expect(item_response.class).to eq(Hash)
    expect(item_response.length).to eq(1)
    expect(item_response[:data]).to have_key(:id)
    expect(item_response[:data][:id]).to eq("#{item.id}")
    expect(item_response[:data]).to have_key(:type)
    expect(item_response[:data][:type]).to eq('item')
    expect(item_response[:data]).to have_key(:attributes)
    expect(item_response[:data][:attributes]).to have_key(:name)
    expect(item_response[:data][:attributes][:name]).to eq(item.name)
    expect(item_response[:data][:attributes]).to have_key(:description)
    expect(item_response[:data][:attributes][:description]).to eq(item.description)
    expect(item_response[:data][:attributes]).to have_key(:unit_price)
    expect(item_response[:data][:attributes][:unit_price]).to eq(item.unit_price)
    expect(item_response[:data][:attributes]).to have_key(:merchant_id)
    expect(item_response[:data][:attributes][:merchant_id]).to eq(item.merchant_id)
  end

  it 'can return an item based on created date search' do
    create_list(:item, 9)
    item = Item.first

    get "/api/v1/items/find?created_at=#{item.created_at}"

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    item_response = JSON.parse(response.body, symbolize_names: true)

    expect(item_response.class).to eq(Hash)
    expect(item_response.length).to eq(1)
    expect(item_response[:data]).to have_key(:id)
    expect(item_response[:data][:id]).to eq("#{item.id}")
    expect(item_response[:data]).to have_key(:type)
    expect(item_response[:data][:type]).to eq('item')
    expect(item_response[:data]).to have_key(:attributes)
    expect(item_response[:data][:attributes]).to have_key(:name)
    expect(item_response[:data][:attributes][:name]).to eq(item.name)
    expect(item_response[:data][:attributes]).to have_key(:description)
    expect(item_response[:data][:attributes][:description]).to eq(item.description)
    expect(item_response[:data][:attributes]).to have_key(:unit_price)
    expect(item_response[:data][:attributes][:unit_price]).to eq(item.unit_price)
    expect(item_response[:data][:attributes]).to have_key(:merchant_id)
    expect(item_response[:data][:attributes][:merchant_id]).to eq(item.merchant_id)
  end

  it 'can return an item based on updated date search' do
    create_list(:item, 9)
    item = Item.first

    get "/api/v1/items/find?updated_at=#{item.updated_at}"

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    item_response = JSON.parse(response.body, symbolize_names: true)

    expect(item_response.class).to eq(Hash)
    expect(item_response.length).to eq(1)
    expect(item_response[:data]).to have_key(:id)
    expect(item_response[:data][:id]).to eq("#{item.id}")
    expect(item_response[:data]).to have_key(:type)
    expect(item_response[:data][:type]).to eq('item')
    expect(item_response[:data]).to have_key(:attributes)
    expect(item_response[:data][:attributes]).to have_key(:name)
    expect(item_response[:data][:attributes][:name]).to eq(item.name)
    expect(item_response[:data][:attributes]).to have_key(:description)
    expect(item_response[:data][:attributes][:description]).to eq(item.description)
    expect(item_response[:data][:attributes]).to have_key(:unit_price)
    expect(item_response[:data][:attributes][:unit_price]).to eq(item.unit_price)
    expect(item_response[:data][:attributes]).to have_key(:merchant_id)
    expect(item_response[:data][:attributes][:merchant_id]).to eq(item.merchant_id)
  end
end
