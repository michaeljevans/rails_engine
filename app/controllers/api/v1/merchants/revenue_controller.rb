class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.highest_revenues(num_merchants[:quantity]))
  end

  private

  def num_merchants
    params.permit(:quantity)
  end
end
