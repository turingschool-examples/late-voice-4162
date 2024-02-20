require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many(:items).through(:customers_items) }
  end
end