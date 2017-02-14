class AddSlugToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :slug, :string
    add_index :notes, :slug, unique: true
  end
end
