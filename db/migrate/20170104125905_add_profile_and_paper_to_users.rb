class AddProfileAndPaperToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile, :text
    add_column :users, :paper, :text
  end
end
