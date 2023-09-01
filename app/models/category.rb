class Category < ApplicationRecord
	has_many :dishes
	validates :name, presence: true
	accepts_nested_attributes_for :dishes, allow_destroy: true

	before_save :remove_space

	private
	def remove_space
    self.name = name.strip()
  end

end
