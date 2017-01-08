class Note < ActiveRecord::Base
  belongs_to :author, class_name: "User", foreign_key: :user_id

  # 作者有權限編輯
  def is_written_by?(user)
    user && user == author
  end

  # 授權的人能夠編輯 
  def is_authorized_to_edit_by?(user)
    post_authority.where(post_id: self.id, user_id: user.id)
  end
end
