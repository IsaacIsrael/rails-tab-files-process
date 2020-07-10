require 'rails_helper'

RSpec.describe Purchase, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it { should belong_to(:item) }

  it { should have_db_column(:name).of_type(:string) }
  it { should have_db_column(:count).of_type(:integer) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:count) }
  it { should validate_numericality_of(:count).is_greater_than_or_equal_to(0).only_integer }

  it { should accept_nested_attributes_for(:item) }

   describe 'should find or create item by description and merchant name' do
    context 'merchant already exist and item already exist' do
      before { FactoryBot.create(:merchant) }
      before { FactoryBot.create(:item) }
      subject(:item_params) do
        item = FactoryBot.attributes_for(:item)
        item[:merchant_attributes] = FactoryBot.attributes_for(:merchant)
        item
      end
      subject(:purchase) { FactoryBot.build(:purchase, item_attributes: item_params) }
      it { expect { purchase.save! }.to_not change { Item.count } }
      it { expect { purchase.save! }.to_not change { Merchant.count } }
    end
    context 'merchant already exist and item not exist' do
      before { FactoryBot.create(:merchant) }
      subject(:item_params) do
        item = FactoryBot.attributes_for(:item)
        item[:merchant_attributes] = FactoryBot.attributes_for(:merchant)
        item
      end
      subject(:purchase) { FactoryBot.build(:purchase, item_attributes: item_params) }
      it { expect { purchase.save! }.to change { Item.count }.by(1) }
      it { expect { purchase.save! }.to_not change { Merchant.count } }
    end
    context 'item not exist' do
      subject(:item_params) do
        item = FactoryBot.attributes_for(:item)
        item[:merchant_attributes] = FactoryBot.attributes_for(:merchant)
        item
      end
      subject(:purchase) { FactoryBot.build(:purchase, item_attributes: item_params) }
      it { expect { purchase.save! }.to change { Item.count }.by(1) }
      it { expect { purchase.save! }.to change { Merchant.count }.by(1) }
    end
  end

end
