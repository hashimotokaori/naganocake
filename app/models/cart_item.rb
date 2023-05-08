class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  
  has_one_attached :image
  
  def get_image(width, height)
  unless image.attached?
    file_path = Rails.root.join('app/assets/images/CAKE2.jpg')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
  image.variant(resize_to_limit: [width, height]).processed
  end
end