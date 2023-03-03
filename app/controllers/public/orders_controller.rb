class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    @order.shopping_cost = 800
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0){ |sum, item| sum + item.subtotal}
    @order.total_payment = @total
    if params[:order][:select_address]== "my_address"
       @order.postal_code = current_customer.postal_code
       @order.address = current_customer.address
       @order.name = current_customer.fullname_display
    elsif params[:order][:select_address] == "registered_address"
       @address = Address.find(params[:order][:address_id])
       @order.postal_code = @address.postal_code
       @order.address = @address.address
       @order.name = @address.name
    elsif params[:order][:select_address] == "new_address"
      @order.postal_code = params[:order][:postal_code]
      @order.postal_code = params[:order][:address]
      @order.postal_code = params[:order][:name]
    end
  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.shopping_cost = 800
    #@order.total_payment = @order.shopping_cost+@order.order_details.sum(&:subtotal)

    @order.save
    current_customer.cart_items.each do |cart_item|
      order_detail = OrderDetail.new
      order_detail.order_id = @order.id
      order_detail.item_id = cart_item.item.id
      order_detail.amount = cart_item.amount
      order_detail.price = cart_item.item.with_tax_price
      order_detail.save
    end
    current_customer.cart_items.destroy_all
    redirect_to orders_complete_path
  end

  def index
    @order = current_customer.orders.all
  end

  def show
    @order = Order.find(params[:id])
    @order.shopping_cost = 800
    @order_details = @order.order_details
    @total = 0
  end

   private
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :payment_method, :shopping_cost, :total_payment, :status)
  end
end
