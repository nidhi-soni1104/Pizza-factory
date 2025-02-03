class CreateInventories < ActiveRecord::Migration[8.0]
  def change
    create_table :inventories do |t|
      t.string :item_type
      t.string :item_name
      t.integer :quantity, default: 0, null: false


      t.timestamps
    end
  end
end
