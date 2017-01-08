class AddSchoolInformationToUser < ActiveRecord::Migration
  def change
    add_column :users, :has_graduated,                   :boolean, default: false
    add_column :users, :academic_degree,                 :string,  default: "college"
    add_column :users, :joined_CYCU_at_which_year,       :integer
    add_column :users, :has_spent_how_much_time_at_CYCU, :integer
  end
end
