class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string   :author
      t.string   :title
      t.text     :content
      t.boolean  :is_editable
      t.string   :link_text
      t.string   :link_site
      t.timestamps null: false
    end
  end
end
