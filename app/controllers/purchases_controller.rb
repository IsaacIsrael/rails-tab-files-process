class PurchasesController < ApplicationController
  def create
    params = file_params || {}
    @response = UploadAndSumPurchases.call(file: params[:purchases]&.tempfile)
  end

  private

  def file_params
    params.require(:file).permit(:purchases) if params[:file].present?
  end
end
