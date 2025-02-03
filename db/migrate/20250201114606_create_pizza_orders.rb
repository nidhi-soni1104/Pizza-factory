class CreatePizzaOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :pizza_orders do |t|
      t.references :order, null: false, foreign_key: true
      t.references :pizza_menu, null: false, foreign_key: true
      t.string :size
      t.string :crust

      t.timestamps
    end
  end
end
