class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :direction
      t.string :phone

      t.timestamps
    end
  end
end
