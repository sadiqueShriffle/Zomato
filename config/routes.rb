Rails.application.routes.draw  do
  root 'users#welcome'

  # User routes
  post '/login', to: 'authentication#login'
  post "/signup", to: "users#create"
  resource :user,  except: :create

  # Restaurent routes
  get '/restaurent/search' , to: "restaurents#search"
  resources :restaurents 

  # Dish Routes
  resources :dishes
  get '/dish/search', to: 'dishes#search_dish'
  get '/category/search', to: 'dishes#filter_by_category'

  # Cart Routes
  post '/additems' , to: "carts#add_item"
  resource :cart
  post '/clear_cart' ,to: "carts#clear_cart"

  # Orders Routes
  resources :orders
  
end
