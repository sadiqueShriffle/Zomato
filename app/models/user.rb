class User < ApplicationRecord
	has_secure_password

	has_many :restaurents , dependent: :destroy
	has_many :orders  , dependent: :destroy
	has_one  :cart , dependent: :destroy
	has_many :categories, through: :restaurents
	has_many :dishes, through: :categories
	has_many :cart_items, through: :cart
	has_many :cart_dish, through: :cart_items
	has_many :order_items, through: :orders

	
	before_save :remove_space

	validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message:"Invalid email id!!!!" }

	def remove_space
    self.name = name.strip()
		self.email = email.strip()
  end

	def owner?
		type == "Owner" 
	end
	def customer?
		type == "Customer"
	end

end
