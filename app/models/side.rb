class Side < ApplicationRecord
  has_many :order_sides

  validates :name, presence: true
end
