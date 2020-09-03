class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.highest_revenues(num_merchants[:quantity]))
  end

  def show
    render json: RevenueSerializer.new(RevenueFacade.total_merchant_revenue(params[:id]))
  end

  private

  def num_merchants
    params.permit(:quantity)
  end
end
