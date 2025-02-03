# app/services/order_processor.rb
class OrderProcessor
  # Checks that inventory is available for every pizza, topping, and side in the order.
  def self.check_inventory(order)
    order.pizza_orders.each do |pizza_order|
      pizza_name = pizza_order.pizza_menu.name
      pizza_inventory = Inventory.find_by(item_type: "pizza", item_name: pizza_name)
      if pizza_inventory.nil? || pizza_inventory.quantity < 1
        return { success: false, message: "Insufficient inventory for pizza: #{pizza_name}" }
      end

      pizza_order.pizza_toppings.each do |pt|
        topping_name = pt.topping.name
        topping_inventory = Inventory.find_by(item_type: "topping", item_name: topping_name)
        if topping_inventory.nil? || topping_inventory.quantity < 1
          return { success: false, message: "Insufficient inventory for topping: #{topping_name}" }
        end
      end
    end

    order.order_sides.each do |order_side|
      side_name = order_side.side.name
      side_inventory = Inventory.find_by(item_type: "side", item_name: side_name)
      if side_inventory.nil? || side_inventory.quantity < 1
        return { success: false, message: "Insufficient inventory for side: #{side_name}" }
      end
    end

    { success: true }
  end

  # Deducts inventory after an order is successfully placed.
  def self.deduct_inventory(order)
    order.pizza_orders.each do |pizza_order|
      pizza_name = pizza_order.pizza_menu.name
      pizza_inventory = Inventory.find_by(item_type: "pizza", item_name: pizza_name)
      pizza_inventory.decrement!(:quantity)

      pizza_order.pizza_toppings.each do |pt|
        topping_name = pt.topping.name
        topping_inventory = Inventory.find_by(item_type: "topping", item_name: topping_name)
        topping_inventory.decrement!(:quantity)
      end
    end

    order.order_sides.each do |order_side|
      side_name = order_side.side.name
      side_inventory = Inventory.find_by(item_type: "side", item_name: side_name)
      side_inventory.decrement!(:quantity)
    end
  end
end
