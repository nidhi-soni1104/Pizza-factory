# db/seeds.rb

# Clear existing data to avoid duplicates (optional)
PizzaMenu.destroy_all
Topping.destroy_all
Side.destroy_all
Inventory.destroy_all

puts "Seeding Pizza Menus..."
PizzaMenu.create!([
  { name: "Deluxe Veggie", category: "Vegetarian", price_regular: 150, price_medium: 200, price_large: 325 },
  { name: "Cheese and corn", category: "Vegetarian", price_regular: 175, price_medium: 375, price_large: 475 },
  { name: "Paneer Tikka", category: "Vegetarian", price_regular: 160, price_medium: 290, price_large: 340 },
  { name: "Non-Veg Supreme", category: "Non-Vegetarian", price_regular: 190, price_medium: 325, price_large: 425 },
  { name: "Chicken Tikka", category: "Non-Vegetarian", price_regular: 210, price_medium: 370, price_large: 500 },
  { name: "Pepper Barbecue Chicken", category: "Non-Vegetarian", price_regular: 220, price_medium: 380, price_large: 525 }
])
puts "Pizza Menus seeded."

puts "Seeding Toppings..."
Topping.create!([
  # Vegetarian toppings
  { name: "Black olive", topping_type: "veg", price: 20 },
  { name: "Capsicum", topping_type: "veg", price: 25 },
  { name: "Paneer", topping_type: "veg", price: 35 },
  { name: "Mushroom", topping_type: "veg", price: 30 },
  { name: "Fresh tomato", topping_type: "veg", price: 10 },
  # Non-Vegetarian toppings
  { name: "Chicken tikka", topping_type: "nonveg", price: 35 },
  { name: "Barbeque chicken", topping_type: "nonveg", price: 45 },
  { name: "Grilled chicken", topping_type: "nonveg", price: 40 },
  # Extra cheese topping
  { name: "Extra cheese", topping_type: "extra_cheese", price: 35 }
])
puts "Toppings seeded."

puts "Seeding Sides..."
Side.create!([
  { name: "Cold drink", price: 55 },
  { name: "Mousse cake", price: 90 }
])
puts "Sides seeded."

puts "Seeding Inventory..."
Inventory.create!([
  # Inventory for toppings
  { item_type: "topping", item_name: "Black olive", quantity: 100 },
  { item_type: "topping", item_name: "Capsicum", quantity: 100 },
  { item_type: "topping", item_name: "Paneer", quantity: 100 },
  { item_type: "topping", item_name: "Mushroom", quantity: 100 },
  { item_type: "topping", item_name: "Fresh tomato", quantity: 100 },
  { item_type: "topping", item_name: "Chicken tikka", quantity: 100 },
  { item_type: "topping", item_name: "Barbeque chicken", quantity: 100 },
  { item_type: "topping", item_name: "Grilled chicken", quantity: 100 },
  { item_type: "topping", item_name: "Extra cheese", quantity: 100 },
  # Inventory for sides
  { item_type: "side", item_name: "Cold drink", quantity: 100 },
  { item_type: "side", item_name: "Mousse cake", quantity: 100 },
  # Inventory for pizzas (if needed for additional logic)
  { item_type: "pizza", item_name: "Deluxe Veggie", quantity: 50 },
  { item_type: "pizza", item_name: "Cheese and corn", quantity: 50 },
  { item_type: "pizza", item_name: "Paneer Tikka", quantity: 50 },
  { item_type: "pizza", item_name: "Non-Veg Supreme", quantity: 50 },
  { item_type: "pizza", item_name: "Chicken Tikka", quantity: 50 },
  { item_type: "pizza", item_name: "Pepper Barbecue Chicken", quantity: 50 }
])
puts "Inventory seeded."

puts "Seeding completed successfully!"
