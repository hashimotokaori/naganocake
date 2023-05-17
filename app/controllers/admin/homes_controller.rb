class Admin::HomesController < ApplicationController
    before_action :set_search
    before_action :authenticate_admin!
    
    def top
    @orders = Order.where("created_at" === Date.today)
    @orders = Order.page(params[:page])
    @items = Item.all.order(created_at: :desc)
    #whereは与えられた条件にマッチするレコードを全て返す
    #今回は今日来た注文の日をマッチさせている
    #参考URLはこれhttps://easyramble.com/get-today-record-with-rails-activerecord.html
    end
    
    def set_search
    @search = Order.ransack(params[:q])
    @orders = @search.result
    end
    
    def set_search
    @search = OrderDetail.ransack(params[:q])
    @order_details = @search.result
    end
end
