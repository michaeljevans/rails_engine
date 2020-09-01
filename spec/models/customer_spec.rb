require 'rails_helper'

RSpec.describe Customer do
  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :first_name }
  end

  describe 'relationships' do
    it { should have_many :invoices }
  end
end
