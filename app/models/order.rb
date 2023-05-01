class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum order_status: { "入金待ち": 0, "入金確認": 1, "製作中": 2, "発送準備中": 3, "発送済み": 4 }
  
  def self.ransackable_attributes(auth_object = nil)
    ["billing_amount", "created_at", "customer_id", "id", "payment_method", "postage", "shipping_address", "shipping_name", "shipping_postal_code", "status", "updated_at"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["customer", "order_details"]
  end

end