require 'rails_helper'

def file_upload(name)
  Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/files/#{name}")
end

RSpec.describe PurchasesController, type: :controller do
  it { should route(:post, '/purchases').to(action: :create) }
  describe "POST #create" do
    let(:file) { file_upload "example_input.tab" }
    context 'passing file' do
      subject { post :create, params: { file: { purchases: file } }, as: :js }
      it { expect(response).to be_successful }
      it { should have_http_status(:ok) }
      it do
        params = { file: { purchases: file } }
        should permit(:purchases).for(:create, params: params).on(:file)
      end
    end

    context 'dont passing file' do
      subject { post :create, params: { file: {} }, as: :js }
      it { expect(response).to be_successful }
      it { should have_http_status(:ok ) }
    end
  end
end
