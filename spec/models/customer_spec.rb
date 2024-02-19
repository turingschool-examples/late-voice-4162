require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many :customeritems}
    it { should have_many(:items).through(:customeritems) }
  end
end
