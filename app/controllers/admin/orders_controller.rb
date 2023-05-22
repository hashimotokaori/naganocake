class Admin::OrdersController < ApplicationController
    before_action :authenticate_admin!
    
    def index
    	@orders = Order.all.page(params[:page]).per(10).order('created_at DESC')
		@search = Order.ransack(params[:q])
        @orders = @search.result.page(params[:page]).per(10)
	end

	def show
		@order = Order.find(params[:id])
		@order_details = @order.order_details
	end

	def total(items_total_price)

	end

	def update
		@order = Order.find(params[:id])
        @order.update(order_params)
        flash[:notice] = "注文ステータスの変更しました"
        redirect_to admin_order_path(@order)

        if @order.status == "入金確認"
        @order.order_details.each do |order_detail|
        order_detail.update(making_status: 1)
        end
        end
        end


  private
	def order_params
		params.require(:order).permit(:order_status)
	end
end
