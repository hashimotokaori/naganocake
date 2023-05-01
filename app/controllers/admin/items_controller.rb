class Admin::ItemsController < ApplicationController
    before_action :authenticate_admin!,only: [:create,:edit,:update,:index, :show, :new]
  
  def new
    @items = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] ="Product was successfully created"
      redirect_to admin_item_path(@item)
    else
      render "new"
    end
  end
  
  def index
    @items = Item.all.page(params[:page]).per(10)
  end
    
  def show
    @item = Item.find(params[:id])
  end


  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] ="Product was successfully updated"
      redirect_to admin_item_path(@item)
    else
      render "show"
    end
  end

  private
  def item_params
    params.require(:item).permit(:genre_id, :name, :description, :price_without_tax, :image, :is_sales_status)
  end
    
end
