class RestaurentsController < ApplicationController
	skip_before_action :customer_check
	skip_before_action :owner_check , only: [:index,:search,:show]

	before_action :set_values , only: [:show,:update , :destroy]

	def index
		return render json: @current_user.restaurents.paginate(page: params[:page], per_page: 1) if @current_user.owner?
		restaurent = Restaurent.where(status: 'open').paginate(page: params[:page], per_page: 2)
		render json: restaurent
	end

	def show 
		if @current_user.owner?
			dish = @current_user.restaurents.includes(categories: :dishes).find(params[:id]) 
    	render json: dish, include: { categories: { include: :dishes } } 
		else	
			dish= Restaurent.find(params[:id])
			render json: dish, include: { categories: { include: :dishes } } 
		end
	end

	def new
		@restaurent = @current_user.restaurents.new
		@restaurent.categories.new 
		@restaurent.categories.each {|category| category.dishes.new}
	end

	def create
		@restaurent = @current_user.restaurents.new(restaurent_params)
		if @restaurent.save
			render json: @restaurent, status:200
		else
			render json: 'Error While Creating'
		end
	end

	def update
		return render json: {message: " Updated successfully!!", data:@restaurent}	if @restaurent.update(restaurent_params)
		render json: {errors: @restaurent.errors.full_messages}
	end

	def destroy
		return render json: {message: " Restaurent Deleted successfully!!", data:@restaurent} if @restaurent.destroy
		render json: {errors: @restaurent.errors.full_messages}
	end

	def search
    restaurent = Restaurent.where("name like ?","%" +params[:name].strip+ "%")
    return  render json: restaurent unless restaurent.empty?
    render json: {error: "No such restaurent found... "}                
  end

	private
	def restaurent_params
		params.require(:restaurent).permit(
			:name,
			:place,
			:status,
				categories_attributes: [
					:id,
					:name, 
						dishes_attributes: [
							:id, 
							:name,
							:price,
							:dish_type
							
						]
				]
		)
	end

	def set_values
		@restaurent = Restaurent.find(params[:id])
	end

end

