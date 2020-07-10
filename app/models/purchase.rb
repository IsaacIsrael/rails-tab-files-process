class Purchase < ApplicationRecord
  belongs_to :item
  validates_presence_of :count, :name
  validates_numericality_of :count,
                            greater_than_or_equal_to: 0,
                            only_integer: true

  accepts_nested_attributes_for :item

  private

  def autosave_associated_records_for_item
    self.item = Item.joins(:merchant)
                    .where(
                      items: { description: item.description },
                      merchants: { name: item.merchant.name }
                    )
                    .first_or_create do |i|
                      i.description = item.description
                      i.merchant = item.merchant
                      i.price = item.price
                    end
  end
end
