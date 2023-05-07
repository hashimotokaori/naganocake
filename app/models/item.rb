class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :orders, through: :order_details

  has_one_attached :image
  validates :name, {presence: true}
  validates :price, {presence: true}
  validates :introduction, presence: true
  # validates :is_active, inclusion: {in: [true, false]}

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "genre_id", "id", "introduction", "is_active", "name", "price", "updated_at"]
  end
  
  def get_image(width, height)
  unless image.attached?
    file_path = Rails.root.join('app/assets/images/CAKE2.jpg')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
  image.variant(resize_to_limit: [width, height]).processed
end
  
end