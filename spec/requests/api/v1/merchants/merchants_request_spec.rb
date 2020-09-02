require 'rails_helper'

RSpec.describe 'Merchants API' do
  it 'returns a list of all merchants' do
    create_list(:merchant, 6)

    get '/api/v1/merchants'

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    merchants_response = JSON.parse(response.body, symbolize_names: true)

    expect(merchants_response.class).to eq(Hash)
    expect(merchants_response[:data].length).to eq(6)
    expect(merchants_response[:data].first).to have_key(:id)
    expect(merchants_response[:data].first).to have_key(:type)
    expect(merchants_response[:data].first).to have_key(:attributes)
    expect(merchants_response[:data].first[:attributes]).to have_key(:name)
  end

  it 'returns one merchant by its id' do
    merchant = create(:merchant)
    id = merchant.id

    get "/api/v1/merchants/#{id}"

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    merchant_response = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_response.class).to eq(Hash)
    expect(merchant_response[:data][:id]).to eq("#{id}")
    expect(merchant_response[:data][:type]).to eq('merchant')
    expect(merchant_response[:data][:attributes][:name]).to eq(merchant.name)
  end

  it 'can create a new merchant' do
    headers = { 'CONTENT_TYPE': 'application/json' }
    merchant_params = { name: Faker::Company.name }

    post '/api/v1/merchants',
      headers: headers,
      params: JSON.generate(merchant_params)

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    merchant_response = JSON.parse(response.body, symbolize_names: true)

    merchant = Merchant.last

    expect(merchant_response.class).to eq(Hash)
    expect(merchant_response[:data][:id]).to eq("#{merchant.id}")
    expect(merchant_response[:data][:type]).to eq('merchant')
    expect(merchant_response[:data][:attributes][:name]).to eq(merchant.name)
  end

  it 'can update an existing merchant' do
    id = create(:merchant).id
    old_name = Merchant.last.name

    headers = { 'CONTENT_TYPE': 'application/json' }
    merchant_params = { name: 'Jabroni' }

    patch "/api/v1/merchants/#{id}",
      headers: headers,
      params: JSON.generate(merchant_params)

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    merchant_response = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_response.class).to eq(Hash)
    expect(merchant_response[:data][:id]).to eq("#{id}")
    expect(merchant_response[:data][:type]).to eq('merchant')
    expect(merchant_response[:data][:attributes][:name]).to eq(merchant_params[:name])

    merchant = Merchant.find_by(id: id)

    expect(merchant.name).to_not eq(old_name)
    expect(merchant.name).to eq(merchant_params[:name])
  end

  it 'can destroy an existing merchant' do
    merchant = create(:merchant)

    expect(Merchant.count).to eq(1)

    expect{ delete "/api/v1/merchants/#{merchant.id}" }.to change(Merchant, :count).by(-1)

    expect(response).to be_successful
    expect(response.status).to eq(204)

    expect(Merchant.count).to eq(0)
    expect{ Merchant.find(merchant.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
