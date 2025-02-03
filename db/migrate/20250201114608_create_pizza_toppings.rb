class CreatePizzaToppings < ActiveRecord::Migration[8.0]
  def change
    create_table :pizza_toppings do |t|
      t.references :pizza_order, null: false, foreign_key: true
      t.references :topping, null: false, foreign_key: true

      t.timestamps
    end
  end
end
