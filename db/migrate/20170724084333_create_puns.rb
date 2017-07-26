class CreatePuns < ActiveRecord::Migration[5.1]
  def change
    create_table(:puns) do |t|
      t.column(:pun, :string)
      t.column(:upvote, :integer)
      t.column(:downvote, :integer)
      t.column(:author_id, :integer)
      t.column(:category_id, :integer)
    end
  end
end
