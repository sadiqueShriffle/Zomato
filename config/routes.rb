Rails.application.routes.draw  do
  # root 'dish#index'
  post '/login', to: 'authentication#login'
  post "/signup", to: "users#create"
  resource :user,  except: :create


  get '/restaurent/search' , to: "restaurents#search"
  resources :restaurents 

  resource :dishes
  get '/dish/search', to: 'dishes#search_dish'
  get '/category/search', to: 'dishes#filter_by_category'

  
  post '/additems' , to: "carts#add_item"
  # post '/update' , to: "carts#update_item"
  resource :cart

  
  resources :orders

  
end
