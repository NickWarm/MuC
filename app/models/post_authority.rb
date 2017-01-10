class PostAuthority < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  accepts_nested_attributes_for :post, :user
end
