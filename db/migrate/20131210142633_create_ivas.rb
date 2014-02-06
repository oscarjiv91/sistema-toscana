class CreateIvas < ActiveRecord::Migration
  def change
    create_table :ivas do |t|
      t.integer :iva

      t.timestamps
    end
  end
end
