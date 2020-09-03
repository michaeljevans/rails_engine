class RevenueFacade
  def self.revenue_in_interval(dates)
    first = dates[:start]
    last  = dates[:end]
    total = Invoice.joins(:invoice_items, :transactions)
      .where(updated_at: Date.parse(first).beginning_of_day..Date.parse(last).end_of_day)
      .where(status: 'shipped')
      .where("transactions.result='success'")
      .sum('invoice_items.quantity * invoice_items.unit_price')
    Revenue.new(total)
  end

  def self.total_merchant_revenue(merchant_id)
    total = Merchant.joins(invoices: [:invoice_items, :transactions])
      .where(id: merchant_id)
      .where("invoices.status='shipped' AND transactions.result='success'")
      .sum('invoice_items.quantity * invoice_items.unit_price')
    Revenue.new(total)
  end
end
