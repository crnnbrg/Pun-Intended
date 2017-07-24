class AddDefaultValuesUpvote < ActiveRecord::Migration[5.1]
  def change
    change_column(:puns, :upvote, :string, :default => 0)
  end
end
