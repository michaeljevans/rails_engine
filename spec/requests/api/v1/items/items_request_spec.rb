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
end
