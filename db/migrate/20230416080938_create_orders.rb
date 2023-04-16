class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.string :shipping_postal_code
      t.string :shipping_address
      t.string :shipping_name
      t.integer :postage
      t.integer :billing_amount
      t.integer :payment_method,default: 0,null: false
      t.integer :status,default: 0,null: false
      t.timestamps
    end
  end
end
