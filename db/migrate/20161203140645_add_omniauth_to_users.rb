class AddOmniauthToUsers < ActiveRecord::Migration
  def change
    #新增facebook api回傳的資料, uid token 一定要有欄位紀錄

    add_column :users, :fb_uid, :string
    add_column :users, :fb_token, :string
    add_column :users, :fb_image, :string
    add_column :users, :fb_name, :string

    add_index :users, :fb_uid
  end
end
