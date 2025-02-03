require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @veg_pizza = PizzaMenu.create!(
      name: "Deluxe Veggie",
      category: "Vegetarian",
      price_regular: 150,
      price_medium: 200,
      price_large: 325
    )
    @nonveg_pizza = PizzaMenu.create!(
      name: "Non-Veg Supreme",
      category: "Non-Vegetarian",
      price_regular: 190,
      price_medium: 325,
      price_large: 425
    )
    @topping1 = Topping.create!(name: "Black olive", topping_type: "veg", price: 20)
    @topping2 = Topping.create!(name: "Chicken tikka", topping_type: "nonveg", price: 35)
    @side = Side.create!(name: "Cold drink", price: 55)
  end

  test "should create a valid vegetarian order" do
    order_params = {
      order: {
        pizza_orders_attributes: [
          {
            pizza_menu_id: @veg_pizza.id,
            size: "medium",
            crust: "New hand tossed",
            pizza_toppings_attributes: [
              { topping_id: @topping1.id }
            ]
          }
        ],
        order_sides_attributes: [
          { side_id: @side.id }
        ]
      }
    }

    post orders_url, params: order_params, as: :json
    assert_response :created
    json_response = JSON.parse(response.body)
    assert_equal "confirmed", json_response["status"]
  end

  test "should reject non-veg pizza with paneer topping" do
    paneer_topping = Topping.create!(name: "Paneer", topping_type: "veg", price: 35)
    order_params = {
      order: {
        pizza_orders_attributes: [
          {
            pizza_menu_id: @nonveg_pizza.id,
            size: "regular",
            crust: "Wheat thin crust",
            pizza_toppings_attributes: [
              { topping_id: paneer_topping.id }
            ]
          }
        ]
      }
    }

    post orders_url, params: order_params, as: :json
    assert_response :unprocessable_entity
    json_response = JSON.parse(response.body)
    assert_includes json_response["errors"].join, "Non-vegetarian pizza cannot have paneer topping"
  end
end
