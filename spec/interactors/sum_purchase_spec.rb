require 'spec_helper'

RSpec.describe SumPurchase, type: :interactor do
  describe '.call' do
    # pending "add some examples to (or delete) #{__FILE__}"
    context 'passing valides atributes' do
      let(:purchase) { FactoryBot.create_list(:purchase, 4)}
      let(:context) { SumPurchase.call(purchase: purchase) }
      it { expect(context).to be_success }
      context 'sum' do
        subject { context.sum }
        it { should eq(Money.new(8000)) }
      end
    end
    context 'passing invalides atributes' do
      let(:purchase) { [
        FactoryBot.build(:purchase, name:""),
        FactoryBot.build(:purchase, name:"")
      ] }
      let(:context) { SumPurchase.call(purchase: purchase) }
      it { expect(context).to be_success }
      context 'purchase' do
        subject { context.sum }
        it { should eq(Money.new(0)) }
      end
    end
    context 'passing one invalides atributes and one valid' do
      let(:purchase) { [
        FactoryBot.build(:purchase),
        FactoryBot.build(:purchase, name:"")
      ] }
      let(:context) { SumPurchase.call(purchase: purchase) }
      it { expect(context).to be_success }
      context 'purchase' do
        subject { context.sum }
        it { should eq(Money.new(2000)) }
      end
    end
    context 'passing empty' do
      let(:context) { SumPurchase.call(purchase: []) }
      it { expect(context).to be_success }
      context 'purchase' do
        subject { context.sum }
        it { should eq(Money.new(0)) }
      end
    end

    context 'passing nil' do
      let(:context) { SumPurchase.call }
      it { expect(context).to be_success }
      context 'purchase' do
        subject { context.sum }
        it { should eq(Money.new(0)) }
      end
    end
  end
end
