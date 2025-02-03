class CreateSides < ActiveRecord::Migration[8.0]
  def change
    create_table :sides do |t|
      t.string :name
      t.integer :price

      t.timestamps
    end
  end
end
