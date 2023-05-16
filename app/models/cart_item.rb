class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  
  validates :amount, numericality: { only_integer: true, greater_than: 0, less_than: 1000 }
  validates :customer_id, :item_id, presence: true

  has_one_attached :image
  
  def with_tax_price
    (price * 1.1).floor
  end
  
  def subtotal
    item.with_tax_price * amount
  end
  
  def get_image(width, height)
  unless image.attached?
    file_path = Rails.root.join('app/assets/images/CAKE2.jpg')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
  image.variant(resize_to_limit: [width, height]).processed
  end
end