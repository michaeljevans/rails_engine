class Api::V1::Merchants::SearchController < ApplicationController
  def show
    render json: MerchantSerializer.new(Merchant.find_merchant(search_param))
  end

  private

  def search_param
    params.permit(:id, :name, :created_at, :updated_at)
  end
end
