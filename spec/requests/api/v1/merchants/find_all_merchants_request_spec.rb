require 'rails_helper'

RSpec.describe 'Merchants API' do
  it 'can return one merchant based on id search' do
    merchant = create(:merchant)
    create(:merchant)

    get "/api/v1/merchants/find_all?id=#{merchant.id}"

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    merchants_response = JSON.parse(response.body, symbolize_names: true)

    expect(merchants_response.class).to eq(Hash)
    expect(merchants_response[:data]).to have_key(:id)
    expect(merchants_response[:data]).to have_key(:type)
    expect(merchants_response[:data][:type]).to eq('merchant')
    expect(merchants_response[:data]).to have_key(:attributes)
    expect(merchants_response[:data][:attributes]).to have_key(:name)
  end

  it 'can return a list of merchants based on name search' do
    merchant = create(:merchant, name: 'Outdoor Goods')
    merchant2 = create(:merchant, name: 'We Got The Goodz')
    merchant3 = create(:merchant, name: 'Not Important')

    get '/api/v1/merchants/find_all?name=good'

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    merchants_response = JSON.parse(response.body, symbolize_names: true)

    expect(merchants_response.class).to eq(Hash)
    expect(merchants_response[:data].length).to eq(2)
    expect(merchants_response[:data].first).to have_key(:id)
    expect(merchants_response[:data].first).to have_key(:type)
    expect(merchants_response[:data].first[:type]).to eq('merchant')
    expect(merchants_response[:data].first).to have_key(:attributes)
    expect(merchants_response[:data].first[:attributes]).to have_key(:name)
  end

  it 'can return a list of merchants based on created date search' do
    merchant = create(:merchant)
    create_list(:merchant, 2)

    get "/api/v1/merchants/find_all?created_at=#{merchant.created_at}"

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    merchants_response = JSON.parse(response.body, symbolize_names: true)

    expect(merchants_response.class).to eq(Hash)
    expect(merchants_response[:data].length).to eq(3)
    expect(merchants_response[:data].first).to have_key(:id)
    expect(merchants_response[:data].first).to have_key(:type)
    expect(merchants_response[:data].first[:type]).to eq('merchant')
    expect(merchants_response[:data].first).to have_key(:attributes)
    expect(merchants_response[:data].first[:attributes]).to have_key(:name)
  end

  it 'can return a list of merchants based on updated date search' do
    merchant = create(:merchant)
    create_list(:merchant, 2)

    get "/api/v1/merchants/find_all?updated_at=#{merchant.updated_at}"

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    merchants_response = JSON.parse(response.body, symbolize_names: true)

    expect(merchants_response.class).to eq(Hash)
    expect(merchants_response[:data].length).to eq(3)
    expect(merchants_response[:data].first).to have_key(:id)
    expect(merchants_response[:data].first).to have_key(:type)
    expect(merchants_response[:data].first[:type]).to eq('merchant')
    expect(merchants_response[:data].first).to have_key(:attributes)
    expect(merchants_response[:data].first[:attributes]).to have_key(:name)
  end
end
