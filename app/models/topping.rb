class Topping < ApplicationRecord
  # topping_type: "veg", "nonveg", or "extra_cheese"
  has_many :pizza_toppings

  validates :name, :topping_type, presence: true
end
