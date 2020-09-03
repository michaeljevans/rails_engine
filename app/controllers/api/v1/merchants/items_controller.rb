class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Merchant.find(params[:id]).items)
  end

  def most_sold
    render json: MerchantSerializer.new(Merchant.most_items_sold(params[:quantity]))
  end
end
