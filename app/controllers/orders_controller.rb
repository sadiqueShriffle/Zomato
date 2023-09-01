class OrdersController < ApplicationController
  skip_before_action :owner_check
  before_action :set_order, only: [:show, :update, :destroy]


  def index
    orders = @current_user.orders.includes(:order_items)
    return  render json: orders unless orders.empty?
    render json: 'No Orders yet'
  end

  def show
    order = @current_user.orders.find_by_id(params[:id])
    render json: order, state:200
  end

  def create
    order = @current_user.orders.new(order_item_params)
    @current_user.cart_items.each do |cart_item|
    order.order_items.new(dish_id: cart_item.dish_id, quantity: cart_item.quantity)
  end

  if order.save
    @current_user.cart.cart_items.destroy_all
      render json: order, status: :created
    else
      render json: order.errors, status: :unprocessable_entity
    end
  end

  def update
    if @order.update(order_params)
      render json: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy
    head :no_content
  end

  private
  def set_order
    @order = @current_user.orders.find(params[:id])
  end

  def order_item_params
    params.permit([:name, :shipping_address])
  end
  
end
