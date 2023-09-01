class DishesController < ApplicationController
  
  skip_before_action :owner_check ,only: [:show ,:search_dish,:filter_by_category,:update]
  skip_before_action :customer_check 
  
  def show
    dish = Dish.all 
    return  render json: dish  if @current_user.customer?
    render json: @current_user.categories, include: :dishes
  end

  def create
    restaurant = params[:restaurent_id]
    category = params[:category_id]
    dish = @current_user.restaurents.find(restaurant).categories.find(category).dishes.new(set_params)
    return render json: dish ,state:200 if dish.save
  end

  def update
    restaurant = params[:restaurent_id]
    category = params[:category_id]
    d_id = params[:dish_id]
    dish = @current_user.restaurents.find(restaurant).categories.find(category).dishes.find(d_id).update(set_params)
    render json: "Dish Updated Successfully", status:200
  end

  def destroy
    restaurant = params[:restaurent_id]
    category = params[:category_id]
    dish_id = params[:dish_id]
    byebug
    @current_user.restaurents.find(restaurant).categories.find(category).dishes.find(dish_id).destroy 
    render json: "Dish Deleted  Successfully", status:200 
  end


  def search_dish
    if params[:name].present? 
      search_by_name
    elsif params[:restaurent_id].present?
      search_by_restaurent_id    
    else
    return render json: Dish.all unless @current_user.customer?

    return render json: @current_user.dishes 
    end
  end


  private
  def search_by_name 
    name = params[:name]
    return render json: 'Name Cannot be blank' if name.blank?
    if @current_user.owner?
      owner_dish
      else
        customer_dish
    end
  end


  def search_by_restaurent_id 
    restaurent_id = params[:restaurent_id]
    return render json: 'Empty Restaurent ID' unless restaurent_id.present?
    restaurent=Restaurent.find(restaurent_id).dishes
    render json: restaurent ,status:200
  end

  def owner_dish
    name = params[:name]
    ow_dish= @current_user.dishes.where(name: name)
    return render json: ow_dish unless ow_dish.empty?
    render json: 'No matching result found'
  end

  def customer_dish
    name = params[:name]
    cu_dish=Dish.where(name: name)
    return render json: cu_dish unless cu_dish.empty?
    render json: 'No matching result found'
  end

  def filter_by_category
    category_name = params[:name]
    return render json: 'Empty Category Name' if category_name.empty?
    restaurent_id = params[:restaurent_id]
    category_data = Category.find_by(name: category_name.strip)    
    if @current_user.owner?
    owner_dish = @current_user.restaurents.find(restaurent_id).categories.find(category_data.id).dishes 
    return render json: owner_dish 
    end
    customer_dish = Restaurent.find(restaurent_id).categories.find(category_data.id).dishes
    render json: customer_dish, status:200
  end


  def set_params
    params.permit(:name ,:price ,:dish_type,:image)
  end 

  # def find_dish_id
  #   @dish = @current_user.restaurants.dishes.find(params[:id])
  #   unless @dish
  #     render json: {error: "Enter valid dish id.."}
  #   end
  #   rescue NoMethodError
  #   render json: {message: "Add restaurant first.."}
  # end



end


