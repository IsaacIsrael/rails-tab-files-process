require 'rails_helper'

RSpec.describe InterpretTabDelimitedFile, type: :interactor do
  describe '.call' do
    context 'passing .tab file' do
      let(:file) { file_fixture "example_input.tab" }
      let(:context) { InterpretTabDelimitedFile.call(file: file) }
      it { expect(context).to be_success }

      context 'data'do
        subject { context.data }
        it { should be_a(Array) }
        it { should all(be_a(Hash)) }
      end
    end

    context 'passing not .tab file' do
      let(:file) { file_fixture "example_input.csv" }
      let(:context){ InterpretTabDelimitedFile.call(file: file) }
      it { expect(context).to_not be_success }

      context 'error'do
        subject { context.error }
        it { should eq "Invalid file type" }
      end
    end

    context 'passing empty .tab file' do
      let(:file) { file_fixture "empty.tab" }
      let(:context) { InterpretTabDelimitedFile.call(file: file) }
      it { expect(context).to be_success }

      context 'data'do
        subject { context.data }
        it { should be_a(Array) }
        it { should all(be_a(Hash)) }
      end
    end

    context 'passing nil' do
      let(:context) { InterpretTabDelimitedFile.call(file: nil) }
      it { expect(context).to_not be_success }

      context 'error'do
        subject { context.error }
        it { should eq "File not exits" }
      end
    end

    context 'passing invalid path  ' do
      let(:context) { InterpretTabDelimitedFile.call(file: "dsjdhkhsdj.tab") }
      it { expect(context).to_not be_success }

      context 'error'do
        subject { context.error }
        it { should eq "File not exits" }
      end
    end
  end
end
