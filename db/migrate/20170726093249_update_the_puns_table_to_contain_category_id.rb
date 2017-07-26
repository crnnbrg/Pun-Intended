class UpdateThePunsTableToContainCategoryId < ActiveRecord::Migration[5.1]
  def change
    add_column(:puns, :category_id, :integer)
  end
end
