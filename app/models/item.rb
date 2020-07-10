class Item < ApplicationRecord
  belongs_to :merchant
  monetize :price_cents,
           presence: true,
           numericality: { greater_than_or_equal_to: 0 }

  validates_presence_of :description

  accepts_nested_attributes_for :merchant

  private

  def autosave_associated_records_for_merchant
    self.merchant = Merchant.where(name: merchant.name)
                            .create_with(address: merchant.address)
                            .first_or_create do |m|
                              m.name = merchant.name
                              m.address = merchant.address
                            end
  end
end
