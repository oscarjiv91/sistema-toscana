class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :cod
      t.string :name
      t.string :last_name
      t.string :address
      t.string :job_address
      t.string :obs

      t.timestamps
    end
  end
end
