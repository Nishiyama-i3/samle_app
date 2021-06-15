class AddColumnUniqueIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :unique_id, :string
  end
end
