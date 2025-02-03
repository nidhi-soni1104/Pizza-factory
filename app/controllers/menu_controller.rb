class MenuController < ApplicationController
  def index
    pizzas   = PizzaMenu.all
    toppings = Topping.all
    sides    = Side.all
    # The available crust types are fixed for now.
    crusts   = ["New hand tossed", "Wheat thin crust", "Cheese Burst", "Fresh pan pizza"]

    render json: {
      pizzas: pizzas,
      toppings: toppings,
      sides: sides,
      crusts: crusts
    }
  end
end
