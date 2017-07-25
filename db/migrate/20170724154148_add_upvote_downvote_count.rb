class AddUpvoteDownvoteCount < ActiveRecord::Migration[5.1]
  def change
    change_column(:puns, :upvote, :integer, :default => 0)
    change_column(:puns, :downvote, :integer, :default => 0)
  end
end
