class Public::OrdersController < ApplicationController
    include Public::OrdersHelper
  before_action :authenticate_customer!
  before_action :cart_check, only: [:new, :confirm, :create]

  def cart_check
    unless CartItem.find_by(customer_id: current_customer.id)
      flash[:danger] = "カートに商品がない状態です"
      redirect_to root_url
    end
  end

  def new
    @order = Order.new
    @shipping_addresses = current_customer.shipping_addresses.all
  end

  def confirm
    @order = Order.new(order_params)
    # @cart_items = CartItem.where(customer_id: current_customer.id)
    # customer = current_customer
    # # address_option = params[:order][:address_option].to_i

    # # @order.payment_method = params[:order][:payment_option].to_i
    # @order.temporary_information_input(customer.id)
    
    if params[:order][:address_option] == "0"
      @order.shipping_postal_code = current_customer.postal_code
      @order.shipping_address = current_customer.address
      @order.shipping_name = current_customer.last_name + current_customer.first_name 
    elsif params[:order][:address_option] == "1"
      ship = Address.find(params[:order][:member_id])
　　　#orderのmember_id(=カラム)でアドレス(帳)を選び、そのデータ送る
      @order.shipping_postal_code = ship.postal_code
      @order.shipping_address = ship.address
      @order.shipping_name = ship.name 
    elsif params[:order][:address_option] = "2"
      @order.shipping_postal_code = params[:order][:shipping_postal_code]
      @order.shipping_address = params[:order][:shipping_address]
      @order.shipping_name = params[:order][:shipping_name]
    else
      render 'new'
    end
      
    @cart_items = current_customer.cart_items.all
    @order.customer_id = current_customer.id
  end
    
      


    # if address_option == 0
    #   @order.order_in_postal_code_address_name(customer.postal_code, customer.address, customer.last_name)
    # elsif address_option == 1
    #   shipping = ShippingAddress.find(params[:order][:registration_shipping_address])
    #   @order.order_in_postcode_address_name(shipping.shipping_postcode, shipping.shipping_address, shipping.shipping_name)
    # elsif address_option == 2
    #   @order.order_in_postcode_address_name(params[:order][:shipping_postcode], params[:order][:shipping_address], params[:order][:shipping_name])
    # else
    # end
    # unless @order.valid?
    #   flash[:danger] = "お届け先の内容に不備があります<br>・#{@order.errors.full_messages.join('<br>・')}"
    #   p @order.errors.full_messages
    #   redirect_back(fallback_location: root_path)
    # end
    # render :new

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.postage = 800
    @order.order_status = 0 
    if @order.save
      @cart_items = CartItem.where(customer_id: current_customer.id)
      @cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.item_id = cart_item.item_id
        order_detail.order_id = @order.id
        order_detail.amount = cart_item.amount
        order_detail.price = cart_item.item.with_tax_price
        order_detail.making_status = 0
        if order_detail.save
          @cart_items.destroy_all
        end
      end
      redirect_to orders_thanks_path
    else
    end
  end
  
  def thanks
  end


  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def index
    @orders = current_customer.orders
    # @orders = Order.where(customer_id: current_customer.id).order(created_at: :desc)
  end

  private

  def order_params
    params.require(:order).permit(:shipping_postal_code, :shipping_address, :shipping_name, :billing_amount, :postage, :payment_method, :billing_amount)
  end

end
