class Public::CartItemsController < ApplicationController
  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
       @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
       @cart_item.amount += params[:cart_item][:amount].to_i
       @cart_item.save
       redirect_to cart_items_path
    else
       @cart_item.save
       @cart_item = current_customer.cart_items.all
       redirect_to cart_items_path
    end
  end

  def index
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0){ |sum, item| sum + item.subtotal}
    @cart_item = CartItem.new
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:customer_id, :item_id, :amount)
  end
end
