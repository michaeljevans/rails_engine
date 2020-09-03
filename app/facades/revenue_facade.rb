class RevenueFacade
  def self.revenue_in_interval(dates)
    start_date = dates[:start]
    end_date   = dates[:end]
    total = Invoice.joins(:invoice_items, :transactions)
      .where(updated_at: Date.parse(start_date).beginning_of_day..Date.parse(end_date).end_of_day)
      .where(status: 'shipped')
      .where("transactions.result='success'")
      .sum('invoice_items.quantity * invoice_items.unit_price')
    Revenue.new(total)
  end
end
