require 'rails_helper'

RSpec.describe 'Merchants API' do
  it 'returns a list of all merchants' do
    create_list(:merchant, 6)

    get '/api/v1/merchants'

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants.length).to eq(6)
  end

  it 'returns one merchant by its id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json')

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:id]).to eq(id)
  end
end
