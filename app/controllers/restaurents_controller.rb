class RestaurentsController < ApplicationController
	# before_action :authenticate_user, except: [:show,:index,:search]

	skip_before_action :customer_check
  skip_before_action :owner_check ,only: [:index,:search ,:show]

	before_action :set_values , only: [:show,:update , :destroy,:new]

	def index
		return render json: @current_user.restaurents if @current_user.owner?
		restaurent = Restaurent.where(status: 'open')
		render json: restaurent
	end

	def show 
		if @current_user.owner?
		dish = @current_user.restaurents.includes(categories: :dishes).find(params[:id]) 
    render json: dish, include: { categories: { include: :dishes } } 
		else
		dish= Restaurent.includes(categories: :dishes).find(params[:id]) 
		render json: dish, include: { categories: { include: :dishes } } 
		end
	end

	def new
		@restaurent = @current_user.restaurents.new
		@restaurent.categories.build 
		@restaurent.categories.each {|category| category.dishes.build}
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
		return render json: @restaurent	if @restaurent.update(restaurent_params)
		render json: @restaurent.errors.full_messages
	end

	def destroy
		return render json: {message: 'Restaurent Remove Successfully'} if @restaurent.destroy
		render json: {message: "Restaurent does't Remove"}
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
		@restaurent = @current_user.restaurents.find(params[:id])
	end

end

# {
#   "restaurent": {
#     "name": "The Naan House",
#     "place": "bhopal",
#     "status": "open",
#     "categories_attributes": [
#       {
#         "name": "Turkish",
#         "dishes_attributes": [
#           { "name": "Kabsa", "price": 770,"dish_type": "veg" },
#           { "name": "Swarma","price": 350,"dish_type": "nonveg" }
#         ]
#       },
#       {
#         "name": "Italian",
#         "dishes_attributes": [
#           { "name": "Pizza", "price": 570,"dish_type": "veg" },
#           { "name": "Risotto","price": 400,"dish_type": "nonveg" }
#         ]
#       }
#     ]
#   }
# }

