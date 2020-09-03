require 'rails_helper'

RSpec.describe Revenue do
  it 'exists and has attributes' do
    rev = Revenue.new(283.23)

    expect(rev).to be_a(Revenue)
    expect(rev.id).to eq(nil)
    expect(rev.revenue).to eq(283.23)
  end
end
