require 'rails_helper'

RSpec.describe Item, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it { should belong_to(:merchant) }

  it { should have_db_column(:description).of_type(:string) }
  it { should have_db_column(:price_cents).of_type(:integer) }
  it { should have_db_column(:price_currency).of_type(:string) }
  it { should monetize(:price).with_currency(:brl) }

  it { should validate_presence_of(:description) }
  # it { should validate_presence_of(:price) }
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }

  it { should accept_nested_attributes_for(:merchant) }

  describe 'should find or create merchant by name' do
    context 'merchant already exist' do
      before { FactoryBot.create(:merchant) }
      subject(:merchant_params) { FactoryBot.attributes_for(:merchant) }
      subject(:item) { FactoryBot.build(:item, merchant_attributes: merchant_params) }
      it { expect { item.save! }.to_not change { Merchant.count} }
    end
    context 'nmerchant not exist' do
      subject(:merchant_params) { FactoryBot.attributes_for(:merchant) }
      subject(:item) { FactoryBot.build(:item, merchant_attributes: merchant_params) }
      it { expect { item.save! }.to change { Merchant.count}.by(1) }
    end
  end
end
