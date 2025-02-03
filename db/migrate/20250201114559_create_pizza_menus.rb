class CreatePizzaMenus < ActiveRecord::Migration[8.0]
  def change
    create_table :pizza_menus do |t|
      t.string :name
      t.string :category
      t.integer :price_regular
      t.integer :price_medium
      t.integer :price_large

      t.timestamps
    end
  end
end
