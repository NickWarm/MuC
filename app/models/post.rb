class Post < ActiveRecord::Base
  validates :title, :content, presence: true

  belongs_to :author, class_name: "User", foreign_key: :user_id
  has_many :post_authorities
  has_many :editors, through: :post_authorities, source: :user

  accepts_nested_attributes_for :post_authorities, allow_destroy: true

  ### 定義在model裡的method可以在view裡使用

  # 作者有權限編輯
  def is_written_by?(user)
    user && user == author
  end
end
