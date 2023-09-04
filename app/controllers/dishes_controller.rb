class DishesController < ApplicationController
  
  skip_before_action :owner_check ,only: [:show ,:search_dish,:filter_by_category,:update]
  skip_before_action :customer_check 
  
  
  def show
    @dish = Dish.all..page params[:page]
    return  render json: dish  if @current_user.customer?
    render json: @current_user.categories, include: :dishes
  end

  def create
    restaurant = params[:restaurent_id]
    category = params[:category_id]
    dish = @current_user.restaurents.find(restaurant).categories.find(category).dishes.new(dish_params)
    return render json: dish ,state:200 if dish.save
    render json: [@user.errors], status: :unprocessable_entity

  end

  def update
    dish = @current_user.restaurents.find(params[:restaurent_id]).categories.find(params[:category_id]).dishes.find(params[:dish_id]).update(dish_params)
    render json: "Dish Updated Successfully", status:200
  end

  def destroy
    @current_user.dishes.find(params[:dish_id]).destroy 
    render json: "Dish Deleted  Successfully", status:200 
  end


  def search_dish
    if params[:name].present? 
      search_by_name
    elsif params[:restaurent_id].present?
      search_by_restaurent_id    
    else
    return render json: Dish.all unless @current_user.customer?
    end
     render json: @current_user.dishes 
  end

  def filter_by_category
    if @current_user.owner?
      owner_dish = @current_user.categories.where("categories.name ILIKE ?", "%#{params[:name].strip}%")
      return render json: owner_dish || [], status: 200
    end
    custoemr_dish = Category.where("name ILIKE ?", "%#{params[:name].strip}%")
    render json: customer_dish || [], status: 200
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
    ow_dish= @current_user.dishes.where("dishes.name ILIKE ?", "%#{params[:name].strip}%")
    return render json: ow_dish unless ow_dish.empty?
    render json: 'No matching result found'
  end

  def customer_dish
    ow_dish= @current_user.dishes.where("dishes.name ILIKE ?", "%#{params[:name].strip}%")
    return render json: cu_dish unless cu_dish.empty?
    render json: 'No matching result found'
  end

  def dish_params
    params.require(:dish).permit(:name ,:price ,:dish_type,images: [])
  end 


end


