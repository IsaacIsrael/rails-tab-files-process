class NormalizeData
  include Interactor

  def call
    context.params = context.data&.each do |item|
      item[:name] = item.delete(:purchaser_name)
      item[:count] = item.delete(:purchase_count)
      item[:item_attributes] = {}
      item[:item_attributes][:description] = item.delete(:item_description)
      item[:item_attributes][:price] = item.delete(:item_price)
      item[:item_attributes][:merchant_attributes] = {}
      item[:item_attributes][:merchant_attributes][:name] = item.delete(:merchant_name)
      item[:item_attributes][:merchant_attributes][:address] = item.delete(:merchant_address)
    end
  end
end
