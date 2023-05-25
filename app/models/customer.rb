class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
         has_many :cart_items, dependent: :destroy
         has_many :orders, dependent: :destroy
         has_many :shipping_addresses, dependent: :destroy

       validates :last_name,  presence: true
       validates :first_name, presence: true
       validates :last_name_kana,  presence: true
       validates :first_name_kana, presence: true
       validates :telephone_number, presence: true
       validates :postal_code,  presence: true
       validates :address, presence: true
       
       def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "email", "encrypted_password", "first_name", "first_name_kana", "id", "last_name", "last_name_kana", "postal_code", "remember_created_at", "reset_password_sent_at", "reset_password_token", "telephone_number", "updated_at"]
       end
       
       def self.ransackable_associations(auth_object = nil)
    ["cart_items", "orders", "shipping_addresses"]
       end
       
        # 退会機能
    def active_for_authentication?
    super && (self.is_customer_status == false)
    end
end
