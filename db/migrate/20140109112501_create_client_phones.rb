class CreateClientPhones < ActiveRecord::Migration
  def change
    create_table :client_phones do |t|
      t.string :phone
      t.integer :client_id

      t.timestamps
    end
  end
end
