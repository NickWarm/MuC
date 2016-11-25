class AddHasGraduatedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :has_graduated, :boolean, default: false
  end
end
