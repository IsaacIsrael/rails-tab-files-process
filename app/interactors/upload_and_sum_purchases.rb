class UploadAndSumPurchases
  include Interactor::Organizer

  organize InterpretTabDelimitedFile, NormalizeData, CreatePurchase, SumPurchase
end
