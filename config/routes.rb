Rails.application.routes.draw  do
  # root 'dish#index'
  post '/login', to: 'authentication#login'
  post "/signup", to: "users#create"
  resource :user,  except: :create


  get '/restaurent/search' , to: "restaurents#search"
  resources :restaurents 

  resources :dishes
  # get '/index', to: 'dishes#index'
  get '/dish/search', to: 'dishes#search_dish'
  get '/category/search', to: 'dishes#filter_by_category'

  # get '/page/:page', action: :index, on: :collection


  
  post '/additems' , to: "carts#add_item"
  # post '/update' , to: "carts#update_item"
  resource :cart

  
  resources :orders

  
end
