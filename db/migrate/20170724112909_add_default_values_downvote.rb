class AddDefaultValuesDownvote < ActiveRecord::Migration[5.1]
  def change
    change_column(:puns, :downvote, :string, :default => 0)
  end
end
