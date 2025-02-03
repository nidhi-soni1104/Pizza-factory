class OrdersController < ApplicationController

    def create
	  Order.transaction do
	    order = Order.new(order_params)
	    total_price = order.pizza_orders.sum { |po| po.calculate_price }
	    total_price += order.order_sides.sum { |os| os.side.price }
	    order.total_price = total_price
	    order.status = "confirmed"

	    # Validate the order and its custom business rules
	    unless order.valid?
	      render json: { errors: order.errors.full_messages }, status: :unprocessable_entity
	      raise ActiveRecord::Rollback
	    end

	    # Check inventory availability
	    inventory_check = OrderProcessor.check_inventory(order)
	    unless inventory_check[:success]
	      render json: { error: inventory_check[:message] }, status: :unprocessable_entity
	      raise ActiveRecord::Rollback
	    end

	    if order.save
	      # Deduct inventory quantities after saving the order
	      OrderProcessor.deduct_inventory(order)
	      render json: order, status: :created
	    else
	      render json: { errors: order.errors.full_messages }, status: :unprocessable_entity
	      raise ActiveRecord::Rollback
	    end
	  end
	end


  def show
    order = Order.find(params[:id])
    render json: order
  end

  # New action: cancel an order
  def cancel
    order = Order.find(params[:id])
    # If the order is already cancelled, return an error.
    if order.status == "cancelled"
      render json: { error: "Order is already cancelled." }, status: :unprocessable_entity
    else
      order.status = "cancelled"
      if order.save
        render json: { message: "Order cancelled successfully.", order: order }
      else
        render json: { errors: order.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  private

  def order_params
    params.require(:order).permit(
      pizza_orders_attributes: [
        :pizza_menu_id, :size, :crust,
        pizza_toppings_attributes: [:topping_id]
      ],
      order_sides_attributes: [:side_id]
    )
  end
end
