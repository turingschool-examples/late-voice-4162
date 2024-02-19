class Customer < ApplicationRecord
    belongs_to :supermarket
    has_many :items
end
