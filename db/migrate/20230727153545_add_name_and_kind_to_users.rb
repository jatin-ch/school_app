class AddNameAndKindToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :kind, :integer
    add_column :users, :active, :boolean
  end
end
