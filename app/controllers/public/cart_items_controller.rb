class Public::CartItemsController < ApplicationController
  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.save
    redirect_to cart_items_path
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
    redirect_to items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:customer_id, :item_id, :amount)
  end
end
