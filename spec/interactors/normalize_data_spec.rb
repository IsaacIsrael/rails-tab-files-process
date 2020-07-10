require 'spec_helper'

RSpec.describe NormalizeData, type: :interactor do
  describe '.call' do
    context 'passing valides atributes' do
      let(:atributes) {
        [{
          purchaser_name: "João Silva",
          purchaser_count: "2",
          item_description: "R$10 off R$20 of food",
          item_price: "10.0",
          merchant_name: "Bob's Pizza",
          merchant_address: "987 Fake St"
        }]
      }
      let(:context) { NormalizeData.call(data: atributes) }

      it { expect(context).to be_success }
      context 'param' do
        subject { context.data }
        it { should be_a(Array) }
        it { should all(be_a(Hash)) }
        it { should all(have_key(:name)) }
        it { should all(have_key(:count)) }
        it { should all(have_key(:item_attributes)) }
        context 'on item_attributes' do
          subject { context.data.map { |item| item[:item_attributes] } }
          it { should all(have_key(:description)) }
          it { should all(have_key(:price)) }
          it { should all(have_key(:merchant_attributes)) }
          context 'on merchant_attributes' do
            subject { context.data.map { |item| item[:item_attributes][:merchant_attributes] } }
            it { should all(have_key(:name)) }
            it { should all(have_key(:address)) }
          end
        end
      end
    end

    context 'passing empty array' do
      let(:context) { NormalizeData.call(data: []) }
      it { expect(context).to be_success }
      context 'param' do
        subject { context.data }
        it { should be_empty }
      end
    end

    context 'passing nil' do
      let(:context) { NormalizeData.call }
      it { expect(context).to be_success }
      context 'param' do
        subject { context.data }
        it { should be_nil }
      end
    end
  end
end
