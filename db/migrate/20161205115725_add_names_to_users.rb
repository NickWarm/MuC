class AddNamesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :taiwan_name, :string
    add_column :users, :english_name, :string
  end
end
