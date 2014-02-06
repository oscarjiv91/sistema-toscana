class CreateProductData < ActiveRecord::Migration
  def change
    create_table :product_data do |t|
      t.integer :quantity
      t.integer :price
      t.integer :product_id

      t.timestamps
    end
  end
end
