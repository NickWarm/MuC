class Note < ActiveRecord::Base
  belongs_to :author, class_name: "User", foreign_key: :user_id

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize.to_s
  end

  def slug_candidates
    [
      :title,
      [:title, :created_at]
    ]
  end

  # 作者有權限編輯
  def is_written_by?(user)
    user && user == author
  end
end
