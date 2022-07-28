class Admin::ItemsController < ApplicationController

  def new
    @item = Item.new
  end

  def index
    @items = Item.page(params[:page])
  end

  def create
   item = Item.new(item_params)
   item.save
   redirect_to admin_items_path
  end

  def show
  end

  def edit
  end

  def update
  end

  private
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :is_active, :image, :genre_id)
  end
end
