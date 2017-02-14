class Post < ActiveRecord::Base
  validates :title, :content, presence: true

  belongs_to :author, class_name: "User", foreign_key: :user_id
  # delegate :email, :to => :author


  has_many :post_authorities                                    # post 與 user 的中介表
  has_many :editors, through: :post_authorities, source: :user  # 多對多

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

  ### 定義在model裡的method可以在view裡使用

  # 作者有權限編輯
  def is_written_by?(user)
    user && user == author
  end

  # 授權的人能夠編輯
  def is_authorized_to_edit_by?(user)
    post_authorities.where(user_id: user.id).present?
  end
end
