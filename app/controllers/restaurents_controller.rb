class RestaurentsController < ApplicationController
	skip_before_action :customer_check
	skip_before_action :owner_check , only: [:index,:search,:show]

	before_action :set_values , only: [:show,:update , :destroy]

	def index
		if @current_user.owner?
		restaurent = @current_user.restaurents
		else
		restaurent = Restaurent.where(status: 'open')
		end
		render json: restaurent, status:200
	end

	def show 
		if @current_user.owner?
			restaurent = @current_user.restaurents.includes(categories: :dishes).find(params[:id]) 
		else	
			restaurent= Restaurent.find(params[:id])
		end
		render json: restaurent, status:200
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
			render json: 'Error While Creating Restaurent', status: :unprocessable_entity
		end
	end

	def update
		if @restaurent.update(restaurent_params)
			render json: {message: " Updated successfully!!", data:@restaurent}, status:200
		else
			render json: {errors: @restaurent.errors.full_messages}, status: :unprocessable_entity
		end
		end

	def destroy
		return render json: {message: " Restaurent Deleted successfully!!", data:@restaurent} if @restaurent.destroy
		render json: {errors: @restaurent.errors.full_messages}, status:404
	end

	def search
    restaurent = Restaurent.where("name like ?","%" +params[:name].strip+ "%")
    return  render json: restaurent unless restaurent.empty?
    render json: {error: "No such restaurent found... "}, status:404            
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

