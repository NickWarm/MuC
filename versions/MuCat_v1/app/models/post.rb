class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User", foreign_key: :user_id
  has_many :post_authorities
  has_many :editors, through: :post_authorities, source: :user
end
