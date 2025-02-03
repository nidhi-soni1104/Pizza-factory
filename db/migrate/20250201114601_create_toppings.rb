class CreateToppings < ActiveRecord::Migration[8.0]
  def change
    create_table :toppings do |t|
      t.string :name
      t.string :topping_type
      t.integer :price

      t.timestamps
    end
  end
end
