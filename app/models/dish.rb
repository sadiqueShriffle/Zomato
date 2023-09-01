class Dish < ApplicationRecord
	paginates_per 25

	belongs_to :category
	has_many :cart_items
	has_many :orders, class_name: 'Order' , foreign_key: 'dish_id'
	has_one_attached :image, dependent: :destroy

	enum dish_type: {veg: 'veg',nonveg: 'nonveg'}

	validates :name,:dish_type ,presence: true

	before_save :remove_space

	private
	def remove_space
    self.name = name.strip()
  end

end
