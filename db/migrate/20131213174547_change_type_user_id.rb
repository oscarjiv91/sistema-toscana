class ChangeTypeUserId < ActiveRecord::Migration
  def change
  	change_column :bill_body_temps, :user_id, :string
  end
end
