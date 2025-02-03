class PizzaOrder < ApplicationRecord
  belongs_to :order
  belongs_to :pizza_menu
  has_many :pizza_toppings, dependent: :destroy

  accepts_nested_attributes_for :pizza_toppings

  validates :size, :crust, presence: true
  validate :validate_toppings

  # Enforce business rules related to toppings.
  def validate_toppings
    if pizza_menu.category == "Vegetarian"
      pizza_toppings.each do |pt|
        if pt.topping.topping_type == "nonveg"
          errors.add(:base, "Vegetarian pizza cannot have non-vegetarian topping")
        end
      end
    elsif pizza_menu.category == "Non-Vegetarian"
      nonveg_count = pizza_toppings.select { |pt| pt.topping.topping_type == "nonveg" }.count
      paneer_present = pizza_toppings.any? { |pt| pt.topping.name.downcase.include?("paneer") }
      errors.add(:base, "Non-vegetarian pizza cannot have paneer topping") if paneer_present
      if nonveg_count > 1
        errors.add(:base, "Non-vegetarian pizza can have only one non-veg topping")
      end
    end
  end

  # Compute the price for this pizza order.
  # For large pizzas, the first two toppings are free.
  def calculate_price
    base_price = case size.downcase
                 when "regular"
                   pizza_menu.price_regular
                 when "medium"
                   pizza_menu.price_medium
                 when "large"
                   pizza_menu.price_large
                 else
                   0
                 end

    topping_prices = pizza_toppings.map { |pt| pt.topping.price }
    extra_price = if size.downcase == "large"
                    # Allow 2 free toppings; extra toppings are charged.
                    extra_toppings = [topping_prices.size - 2, 0].max
                    topping_prices.sort.reverse.take(extra_toppings).sum
                  else
                    topping_prices.sum
                  end

    base_price + extra_price
  end
end
