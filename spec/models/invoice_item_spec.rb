require 'rails_helper'

RSpec.describe InvoiceItem do
  describe 'validations' do
    it { should validate_numericality_of :quantity }
    it { should validate_numericality_of :unit_price }
  end

  describe 'relationships' do
    it { should belong_to :item }
    it { should belong_to :invoice }
  end
end
