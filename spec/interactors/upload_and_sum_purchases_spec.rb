require 'spec_helper'

RSpec.describe UploadAndSumPurchases, type: :interactor do
  describe '.call' do
    context 'passing all valid data on .tab file' do
      let(:file) { file_fixture "example_input.tab" }
      let(:context) { UploadAndSumPurchases.call(file: file) }
      it { expect(context).to be_success }
      it { expect { UploadAndSumPurchases.call(file: file) }.to change { Purchase.count } }
      context 'sum' do
        subject { context.sum }
        it { should eq(Money.new(9500)) }
      end
    end

    context 'passing all invalid data in.tab file' do
      let(:file) { file_fixture "all_invalid.tab" }
      let(:context) { UploadAndSumPurchases.call(file: file) }
      it { expect(context).to_not be_success }
      it { expect { UploadAndSumPurchases.call(file: file) }.to_not change { Purchase.count } }
      it { expect(context).to have_attributes(error: an_instance_of(String)) }
    end

    context 'passing  valid and invalid data on .tab file' do
      let(:file) { file_fixture "example_input_2.tab" }
      let(:context) { UploadAndSumPurchases.call(file: file) }
      it { expect(context).to be_success }
      it { expect { UploadAndSumPurchases.call(file: file) }.to change { Purchase.count } }
      context 'sum' do
        subject { context.sum }
        it { should eq(Money.new(7500)) }
      end
    end

    context 'passing not .tab file' do
      let(:file) { file_fixture "example_input.csv" }
      let(:context) { UploadAndSumPurchases.call(file: file) }
      it { expect(context).to_not be_success }

      context 'error' do
        subject { context.error }
        it { should eq "Invalid file type" }
      end
    end

    context 'passing empty .tab file' do
      let(:file) { file_fixture "empty.tab" }
      let(:context) { UploadAndSumPurchases.call(file: file) }
      it { expect(context).to be_success }

      context 'sum' do
        subject { context.sum }
        it { should eq(Money.new(0)) }
      end
    end

    context 'passing nil' do
      let(:context) { UploadAndSumPurchases.call(file: nil) }
      it { expect(context).to_not be_success }

      context 'error' do
        subject { context.error }
        it { should eq "File not exits" }
      end
    end

    context 'passing invalid path  ' do
      let(:context) { UploadAndSumPurchases.call(file: "dsjdhkhsdj.tab") }
      it { expect(context).to_not be_success }

      context 'error' do
        subject { context.error }
        it { should eq "File not exits" }
      end
    end
  end
end
