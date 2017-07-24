class ChangeAuthorDatatype < ActiveRecord::Migration[5.1]
  def change
    change_column(:puns, :author_id, :string)
  end

end
