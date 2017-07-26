class CreateUser < ActiveRecord::Migration[5.1]
  def change
    create_table(:users) do |t|
      t.column(:username, :string)
      t.column(:email, :string)
      t.column(:password, :string)

      t.timestamp()
    end
  end
end
