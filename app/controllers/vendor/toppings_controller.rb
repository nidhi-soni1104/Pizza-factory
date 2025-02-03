module Vendor
  class ToppingsController < ApplicationController
    def create
      topping = Topping.new(topping_params)
      if topping.save
        render json: topping, status: :created
      else
        render json: { errors: topping.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      topping = Topping.find(params[:id])
      if topping.update(topping_params)
        render json: topping, status: :ok
      else
        render json: { errors: topping.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def topping_params
      params.require(:topping).permit(:name, :topping_type, :price)
    end
  end
end
