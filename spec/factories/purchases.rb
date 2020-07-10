FactoryBot.define do
  factory :purchase do
    name "João Silva"
    count 2
    item_attributes { attributes_for(:item) }
  end
end
