require 'csv'

desc 'Import CSV data'
namespace :db do
  task :seed_from_csv => [:environment] do
    data = {
      Customer =>    './db/data/customers.csv',
      Merchant =>    './db/data/merchants.csv',
      Item =>        './db/data/items.csv',
      Invoice =>     './db/data/invoices.csv',
      Transaction => './db/data/transactions.csv',
      InvoiceItem => './db/data/invoice_items.csv'
    }

    data.each do |object, path|
      object.destroy_all
      ActiveRecord::Base.connection.reset_pk_sequence!("#{object}")
      CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
        row[:unit_price] = row[:unit_price].to_f / 100 if row[:unit_price]
        object.create!(row.to_hash)
      end
    end
  end
end
