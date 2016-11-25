class CreatePostAuthority < ActiveRecord::Migration
  def up
    create_table :post_authorities do |t|
      t.integer :user_id
      t.integer :post_id
    end
  end

  def down
    drop_table :post_authorities
  end
end
