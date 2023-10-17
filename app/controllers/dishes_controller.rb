class DishesController < ApplicationController
  skip_before_action :owner_check ,only: [:show,:index,:search_dish,:filter_by_category]
  skip_before_action :customer_check 

  def index
    if params[:name].present? && params[:restaurent_id].present?
      dishes = filter_by_category
    elsif params[:name].present?
      dishes=search_by_name
    elsif params[:restaurent_id].present?
      dishes=search_by_restaurent_id   
    elsif params[:category_id].present?
      dishes=Category.find(params[:category_id]).dishes    
    else
      if @current_user.customer?
        dishes= Dish.all 
      else
        dishes= @current_user.dishes
      end
    end
    # dishes=dishes.paginate(page: params[:page], per_page: 2)
      render json: dishes
  end
  

  def show
    dish= Dish.find(params[:id])
    render json: dish,status:200  
  end
  
  
  def create
    restaurant = params[:restaurent_id]
    category = params[:category_id]
    dish = @current_user.restaurents.find(restaurant).categories.find(category).dishes.new(dish_params)
    return render json: dish ,state:200 if dish.save
    render json: [dish.errors], status: :unprocessable_entity
  end

  def update
    dish = @current_user.restaurents.find(params[:restaurent_id]).categories.find(params[:category_id]).dishes.find(params[:dish_id]).update(dish_params)
    render json: "Dish Updated Successfully", status:200
  end

  def destroy
    @current_user.dishes.find(params[:dish_id]).destroy 
    render json: "Dish Deleted  Successfully", status:200 
  end

  private
  def search_by_restaurent_id 
    restaurent_id = params[:restaurent_id]
    return render json: 'Empty Restaurent ID' unless restaurent_id.present?
    restaurent=Restaurent.find(restaurent_id).dishes
    return restaurent
  end

  def search_by_name
    dish = Dish.where("dishes.name ILIKE ?", '%#{params[:name].strip}%')
    return dish
  end


  def filter_by_category
    if @current_user.owner?
      owner_dish = @current_user.categories.where("categories.name ILIKE ?", "%#{params[:name].strip}%")
      return owner_dish
    end
    custoemr_dish = Category.where("name ILIKE ?", "%#{params[:name].strip}%")
    return customer_dish
  end

  def owner_dish
    ow_dish= current_user.dishes.where("dishes.name ILIKE ?", "%#{params[:name].strip}%")
    return ow_dish 
  end

  def customer_dish
    cu_dish= Dish.where("dishes.name ILIKE ?", "%#{params[:name].strip}%")
    return cu_dish 
  end


  def dish_params
    params.permit([:name ,:price ,:dish_type])
  end 

end


