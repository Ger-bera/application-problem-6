class AddIntroductionToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :introduction, :string
    add_index :users, :name, unique: true
  end
end
