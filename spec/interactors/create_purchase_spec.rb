require 'spec_helper'

RSpec.describe CreatePurchase, type: :interactor do
  describe '.call' do
    # pending "add some examples to (or delete) #{__FILE__}"
    context 'passing valides atributes' do
      let(:params) { [
        {:name=>"João Silva",
         :count=>"2",
         :item_attributes=>
         {:description=>"R$10 off R$20 of food",
          :price=>"10.0",
          :merchant_attributes=>{:name=>"Bob's Pizza", :address=>"987 Fake St"}}
         },
       {:name=>"Amy Pond",
        :count=>"5",
        :item_attributes=>
         {:description=>"R$30 of awesome for R$10",
          :price=>"10.0",
          :merchant_attributes=>{:name=>"Tom's Awesome Shop", :address=>"456 Unreal Rd"}
         }
        },
       {:name=>"Marty McFly",
        :count=>"1",
        :item_attributes=>
         {:description=>"R$20 Sneakers for R$5",
          :price=>"5.0",
          :merchant_attributes=>{:name=>"Sneaker Store Emporium", :address=>"123 Fake St"}
         }
        },
       {:name=>"Snake Plissken",
        :count=>"4",
        :item_attributes=>
         {:description=>"R$20 Sneakers for R$5",
          :price=>"5.0",
          :merchant_attributes=>{:name=>"Sneaker Store Emporium", :address=>"123 Fake St"}}
         }
      ] }
      let(:context) { CreatePurchase.call(params: params) }
      it { expect(context).to be_success }
      it { expect { CreatePurchase.call(params: params) }.to change { Purchase.count } }
      context 'purchase' do
        subject { context.purchase }
        it { should be_a(Array) }
        it { should all(be_a(Purchase)) }
        it { should all(be_valid) }
      end
    end
    context 'passing invalides atributes' do
      let(:params) { [
        {:name=>"",
         :count=>"2",
         :item_attributes=>
         {:description=>"R$10 off R$20 of food",
          :price=>"10.0",
          :merchant_attributes=>{:name=>"Bob's Pizza", :address=>"987 Fake St"}}
         },
       {:name=>"",
        :count=>"5",
        :item_attributes=>
         {:description=>"R$30 of awesome for R$10",
          :price=>"10.0",
          :merchant_attributes=>{:name=>"Tom's Awesome Shop", :address=>"456 Unreal Rd"}
         }
        }
      ] }
      let(:context) { CreatePurchase.call(params: params) }
      it { expect(context).to_not be_success }
      it { expect { CreatePurchase.call(params: params) }.to_not change { Purchase.count } }
      it { expect(context).to have_attributes(error:an_instance_of(String)) }
      context 'purchase' do
        subject { context.purchase }
        it { should be_a(Array) }
        it { should all(be_a(Purchase)) }
        it { should all(be_invalid) }
      end
    end
    context 'passing one invalides atributes and one valid' do
      let(:params) { [
        {:name=>"dskdjshjk",
         :count=>"2",
         :item_attributes=>
         {:description=>"R$10 off R$20 of food",
          :price=>"10.0",
          :merchant_attributes=>{:name=>"Bob's Pizza", :address=>"987 Fake St"}}
         },
       {:name=>"",
        :count=>"5",
        :item_attributes=>
         {:description=>"R$30 of awesome for R$10",
          :price=>"10.0",
          :merchant_attributes=>{:name=>"Tom's Awesome Shop", :address=>"456 Unreal Rd"}
         }
        }
      ] }
      let(:context) { CreatePurchase.call(params: params) }
      it { expect(context).to be_success }
      it { expect { CreatePurchase.call(params: params) }.to change { Purchase.count }.by(1) }

      context 'purchase' do
        subject { context.purchase }
        it { should be_a(Array) }
        it { should all(be_a(Purchase)) }
        it { is_expected.to include(be_invalid) }
        it { is_expected.to include(be_valid) }
      end
    end
    context 'passing empty' do
      let(:context) { CreatePurchase.call(purchase: []) }
      it { expect(context).to_not be_success }
      it { expect { CreatePurchase.call(params: []) }.to_not change { Purchase.count } }
      it { expect(context).to have_attributes(error:an_instance_of(String)) }
    end

    context 'passing nil' do
      let(:context) { CreatePurchase.call }
      it { expect(context).to_not be_success }
      it { expect(context).to have_attributes(error:an_instance_of(String)) }
      it { expect { CreatePurchase.call }.to_not change { Purchase.count } }
    end
  end
end
