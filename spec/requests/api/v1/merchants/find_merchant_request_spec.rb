require 'rails_helper'

RSpec.describe 'Merchants API' do
  it 'can return a merchant based on id search' do
    create_list(:merchant, 9)
    merchant = Merchant.last

    get "/api/v1/merchants/find?id=#{merchant.id}"

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    merchant_response = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_response.class).to eq(Hash)
    expect(merchant_response.length).to eq(1)
    expect(merchant_response[:data]).to have_key(:id)
    expect(merchant_response[:data][:id]).to eq("#{merchant.id}")
    expect(merchant_response[:data]).to have_key(:type)
    expect(merchant_response[:data][:type]).to eq('merchant')
    expect(merchant_response[:data]).to have_key(:attributes)
    expect(merchant_response[:data][:attributes]).to have_key(:name)
    expect(merchant_response[:data][:attributes][:name]).to eq(merchant.name)
  end

  it 'can return a merchant based on name search' do
    create_list(:merchant, 4)
    merchant = Merchant.last

    get "/api/v1/merchants/find?name=#{merchant.name[1..9]}"

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    merchant_response = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_response.class).to eq(Hash)
    expect(merchant_response.length).to eq(1)
    expect(merchant_response[:data]).to have_key(:id)
    expect(merchant_response[:data][:id]).to eq("#{merchant.id}")
    expect(merchant_response[:data]).to have_key(:type)
    expect(merchant_response[:data][:type]).to eq('merchant')
    expect(merchant_response[:data]).to have_key(:attributes)
    expect(merchant_response[:data][:attributes]).to have_key(:name)
    expect(merchant_response[:data][:attributes][:name]).to eq(merchant.name)
  end

  it 'can return a merchant based on created date search' do
    create_list(:merchant, 9)
    merchant = Merchant.first

    get "/api/v1/merchants/find?created_at=#{merchant.created_at}"

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    merchant_response = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_response.class).to eq(Hash)
    expect(merchant_response.length).to eq(1)
    expect(merchant_response[:data]).to have_key(:id)
    expect(merchant_response[:data][:id]).to eq("#{merchant.id}")
    expect(merchant_response[:data]).to have_key(:type)
    expect(merchant_response[:data][:type]).to eq('merchant')
    expect(merchant_response[:data]).to have_key(:attributes)
    expect(merchant_response[:data][:attributes]).to have_key(:name)
    expect(merchant_response[:data][:attributes][:name]).to eq(merchant.name)
  end

  it 'can return a merchant based on updated date search' do
    create_list(:merchant, 9)
    merchant = Merchant.first

    get "/api/v1/merchants/find?updated_at=#{merchant.updated_at}"

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    merchant_response = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_response.class).to eq(Hash)
    expect(merchant_response.length).to eq(1)
    expect(merchant_response[:data]).to have_key(:id)
    expect(merchant_response[:data][:id]).to eq("#{merchant.id}")
    expect(merchant_response[:data]).to have_key(:type)
    expect(merchant_response[:data][:type]).to eq('merchant')
    expect(merchant_response[:data]).to have_key(:attributes)
    expect(merchant_response[:data][:attributes]).to have_key(:name)
    expect(merchant_response[:data][:attributes][:name]).to eq(merchant.name)
  end
end
