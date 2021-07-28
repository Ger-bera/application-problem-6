class RemoveNameFromUsers < ActiveRecord::Migration[5.2]
  def down
    remove_index :users, :name
  end
end
