class AddBlondeCount < ActiveRecord::Migration[5.1]
  def change
    add_column(:puns, :blonde, :integer, :default => 0)
  end
end
