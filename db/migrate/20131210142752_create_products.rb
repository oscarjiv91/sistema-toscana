class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :cod
      t.string :description
      t.integer :surcharge, :precision => 6
      t.integer :category_id
      t.integer :iva_id

      t.timestamps
    end
  end
end
