# # db/seeds.rb

# # Create users
owner = User.create(name: 'sadique', 'owner@example.com', password: 12345, user_type: 'owner')
customer = User.create(name: 'mohit',email: 'customer@example.com', password: 12345, user_type: 'customer')

# # Create restaurants with categories and dishes
restaurant1 = owner.restaurants.create(name: 'Restaurant 1', place: 'indore',status: 'open')
restaurant2 = owner.restaurants.create(name: 'Restaurant 2', place: 'dewas', status: 'open')

category1 = restaurant1.categories.create(name: 'Chinese')
category2 = restaurant1.categories.create(name: 'Italian')
category3 = restaurant2.categories.create(name: 'Indian')

dish1 = category1.dishes.create(name: 'Noodles', price: 100,dish_type: 'veg')
dish2 = category1.dishes.create(name: 'Mancuriyan', price: 150, dish_type: 'veg')
dish3 = category2.dishes.create(name: 'Pizza', price: 700,dish_type: 'veg')
dish4 = category2.dishes.create(name: 'Pasta', price: 450, dish_type: 'veg')
dish5 = category3.dishes.create(name: 'Biryani', price: 500,dish_type: 'nonveg')
dish6 = category3.dishes.create(name: 'Saahi Paneer', price: 450, dish_type: 'veg')


# # Create a cart and add items
cart = customer.cart || customer.build_cart
cart.cart_items.create(dish: dish1, quantity: 3)
cart.cart_items.create(dish: dish2, quantity: 1)
cart.cart_items.create(dish: dish3, quantity: 2)
cart.cart_items.create(dish: dish6, quantity: 5)

# # Create orders and cart items
order1 = customer.orders.create(name: 'customer_name',shipping_address: '321, Azad Nagar indore')
order2 = customer.orders.create(name: 'Shriffle Technologies',shipping_address: 'Vijay Nagar indore')



customer.cart_items.each do |cart_item|
order1.order_items.create(dish_id: cart_item.dish_id, quantity: cart_item.quantity)
end

customer.cart.cart_items.destroy_all

# second cart_items after destroy
cart = customer.cart || customer.build_cart
cart.cart_items.create(dish: dish3, quantity: 2)
cart.cart_items.create(dish: dish1, quantity: 2)

customer.cart_items.each do |cart_item|
order2.order_items.create(dish_id: cart_item.dish_id, quantity: cart_item.quantity)
end
customer.cart.cart_items.destroy_all
