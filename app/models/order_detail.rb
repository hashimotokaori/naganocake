class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

    enum making_status: { "着手不可": 0, "製作待ち": 1, "製作中": 2, "製作完了": 3 }
    
    def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "item_id", "making_status", "order_id", "price", "quantity", "updated_at"]
    end
    
    def self.ransackable_associations(auth_object = nil)
    ["item", "order"]
    end

end