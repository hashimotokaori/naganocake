class Order < ApplicationRecord
  
  validates :billing_amount, presence: true
  validates :payment_method, presence: true
  validates :postage, presence: true
  validates :shipping_address, length: { in: 1..48 }
  validates :shipping_postal_code, presence: true
  #validates :shipping_postal_code, format: { with: /\A\d{3}[-]\d{4}\z/ }
  validates :shipping_name, length: { in: 1..32 }
  validates :order_status, presence: true
  
  has_many :order_details, dependent: :destroy
  belongs_to :customer
  has_many :items, through: :order_details

  
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum order_status: { "入金待ち": 0, "入金確認": 1, "製作中": 2, "発送準備中": 3, "発送済み": 4 }
  
  def temporary_information_input(current_customer_id)
    self.customer_id = current_customer_id
    self.postage = 800
    self.billing_amount = 1
  end

  def order_in_postcode_address_name(postcode, address, name)
    self.shipping_postal_code = postcode
    self.shipping_address = address
    self.shipping_name = name
  end
  
  def self.ransackable_attributes(auth_object = nil)
    ["billing_amount", "created_at", "customer_id", "id", "payment_method", "postage", "shipping_address", "shipping_name", "shipping_postal_code", "status", "updated_at"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["customer", "order_details"]
  end

end