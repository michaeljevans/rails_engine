require 'csv'

desc 'Import CSV data'
namespace :db do
  task :seed_from_csv => [:environment] do
    Rake::Task['db:drop'].execute
    Rake::Task['db:create'].execute
    Rake::Task['db:migrate'].execute

    data = {
      Customer =>    './db/data/customers.csv',
      Merchant =>    './db/data/merchants.csv',
      Item =>        './db/data/items.csv',
      Invoice =>     './db/data/invoices.csv',
      InvoiceItem => './db/data/invoice_items.csv',
      Transaction => './db/data/transactions.csv'
    }

    data.each do |object, path|
      CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
        row[:unit_price] = row[:unit_price].to_f / 100 if row[:unit_price]
        object.create!(row.to_hash)
      end
      puts "#{object}s successfully seeded!"
      ActiveRecord::Base.connection.reset_pk_sequence!("#{object}")
    end
  end
end
