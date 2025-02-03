class PizzaTopping < ApplicationRecord
  belongs_to :pizza_order
  belongs_to :topping
end
