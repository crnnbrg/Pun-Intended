class AddPunToUser < ActiveRecord::Migration[5.1]
  def change
  	add_column(:puns, :user_id, :integer)
  end
end
