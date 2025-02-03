module Vendor
  class SidesController < ApplicationController
    def create
      side = Side.new(side_params)
      if side.save
        render json: side, status: :created
      else
        render json: { errors: side.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      side = Side.find(params[:id])
      if side.update(side_params)
        render json: side, status: :ok
      else
        render json: { errors: side.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def side_params
      params.require(:side).permit(:name, :price)
    end
  end
end
