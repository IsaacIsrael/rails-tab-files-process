FactoryBot.define do
  factory :item do
    description "R$10 off R$20 of food"
    price 10.00
    merchant_attributes { attributes_for(:merchant) }
  end
end
