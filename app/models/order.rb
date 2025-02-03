class Order < ApplicationRecord
  has_many :pizza_orders, dependent: :destroy
  has_many :order_sides, dependent: :destroy

  accepts_nested_attributes_for :pizza_orders
  accepts_nested_attributes_for :order_sides

  validates :total_price, presence: true
end
