require 'rails_helper'

RSpec.describe Merchant, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it { should have_db_column(:name).of_type(:string) }
  it { should have_db_column(:address).of_type(:string) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address) }
end
