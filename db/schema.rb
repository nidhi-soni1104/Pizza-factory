# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_02_01_114612) do
  create_table "inventories", force: :cascade do |t|
    t.string "item_type"
    t.string "item_name"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_sides", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "side_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_sides_on_order_id"
    t.index ["side_id"], name: "index_order_sides_on_side_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "total_price"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pizza_menus", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.integer "price_regular"
    t.integer "price_medium"
    t.integer "price_large"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pizza_orders", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "pizza_menu_id", null: false
    t.string "size"
    t.string "crust"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_pizza_orders_on_order_id"
    t.index ["pizza_menu_id"], name: "index_pizza_orders_on_pizza_menu_id"
  end

  create_table "pizza_toppings", force: :cascade do |t|
    t.integer "pizza_order_id", null: false
    t.integer "topping_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pizza_order_id"], name: "index_pizza_toppings_on_pizza_order_id"
    t.index ["topping_id"], name: "index_pizza_toppings_on_topping_id"
  end

  create_table "sides", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "toppings", force: :cascade do |t|
    t.string "name"
    t.string "topping_type"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "order_sides", "orders"
  add_foreign_key "order_sides", "sides"
  add_foreign_key "pizza_orders", "orders"
  add_foreign_key "pizza_orders", "pizza_menus"
  add_foreign_key "pizza_toppings", "pizza_orders"
  add_foreign_key "pizza_toppings", "toppings"
end
