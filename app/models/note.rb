class Note < ActiveRecord::Base
  belongs_to :author, class_name: "User", foreign_key: :user_id

  # 作者有權限編輯
  def is_written_by?(user)
    user && user == author
  end
end
