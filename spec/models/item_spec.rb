require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :supermarket }
    it { should have_many :customeritems}
    it { should have_many(:customers).through(:customeritems) }
  end
end