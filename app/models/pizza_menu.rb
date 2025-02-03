class PizzaMenu < ApplicationRecord
  # category should be either "Vegetarian" or "Non-Vegetarian"
  has_many :pizza_orders

  validates :name, :category, presence: true
end
