class CreateSalesmen < ActiveRecord::Migration
  def change
    create_table :salesmen do |t|
      t.string :name
      t.string :phone
      t.integer :supplier_id

      t.timestamps
    end
  end
end
