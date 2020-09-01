FactoryBot.define do
  factory :item do
    name        { Faker::Commerce.product_name }
    description { Faker::Marketing.buzzwords }
    unit_price  { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    merchant
  end
end
