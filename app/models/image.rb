class Image < ActiveRecord::Base
  has_attached_file :image,
    style: {
      original: '1024x1024>',
      medium: '300x300>',
      icon: '150x150#'
    },
    default_url: '/images/missing3.png'
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\z/
end
