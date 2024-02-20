require 'rails_helper'

RSpec.describe CustomerItem, type: :model do
  it { should belong_to :item } 
  it { should belong_to :customer }
end
