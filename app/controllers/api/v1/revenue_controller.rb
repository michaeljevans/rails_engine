class Api::V1::RevenueController < ApplicationController
  def between_dates
    render json: RevenueSerializer.new(RevenueFacade.revenue_in_interval(date_params))
  end

  private

  def date_params
    params.permit(:start, :end)
  end
end
