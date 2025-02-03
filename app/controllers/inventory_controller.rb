class InventoryController < ApplicationController
  
    def restock
	  # Expects params: { inventory: { item_type: "...", item_name: "...", quantity: 10 } }
	  item_type = params[:inventory][:item_type]
	  item_name = params[:inventory][:item_name]
	  quantity  = params[:inventory][:quantity].to_i

	  inventory = Inventory.find_or_initialize_by(item_type: item_type, item_name: item_name)
	  # Initialize quantity to 0 if it's nil, then add the given quantity
	  inventory.quantity = (inventory.quantity || 0) + quantity

	  if inventory.save
	    render json: inventory, status: :ok
	  else
	    render json: { errors: inventory.errors.full_messages }, status: :unprocessable_entity
	  end
	end
end
