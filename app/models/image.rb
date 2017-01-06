class Image < ActiveRecord::Base
  belongs_to :user

  has_attached_file :image,
    styles: {
      original: "1024x1024>",
      medium: "300x300>",
      icon: "150x150#"
    },
    default_url: '/images/missing3.png'
  
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
