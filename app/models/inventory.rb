class Inventory < ApplicationRecord
  # item_type can be "topping", "side", "pizza", etc.
  validates :item_type, :item_name, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
end
