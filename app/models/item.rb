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
  
end