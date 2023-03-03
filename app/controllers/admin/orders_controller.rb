class Admin::OrdersController < ApplicationController
  def show
   @order = Order.find(params[:id])
   @order.shopping_cost = 800
   @order_details = @order.order_details
   @total = @order_details.inject(0){ |sum, item| sum + item.subtotal}
  end

  def update
    order = Order.find(params[:id])
    order.update(order_params)
    if order.status == "paid_up"
       order_details = order.order_details
       order_details.update_all(making_status: "waiting")
    end
    redirect_to admin_order_path(order.id)
  end


   private
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :payment_method, :shopping_cost, :total_payment, :status)
  end
end
