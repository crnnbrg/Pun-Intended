class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table(:categories) do |t|
      t.column(:category, :string)
    end
  end
end
