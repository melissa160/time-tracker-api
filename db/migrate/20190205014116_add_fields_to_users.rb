class AddFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_column :users, :address, :string
    add_column :users, :department, :string
    add_column :users, :age, :integer
  end
end
