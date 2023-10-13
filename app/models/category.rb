class Category < ApplicationRecord
	belongs_to :restaurent
	has_many :dishes , dependent: :destroy
	validates :name, presence: true
	accepts_nested_attributes_for :dishes, allow_destroy: true

	before_save :remove_space

	private
	def remove_space
    self.name = name.strip()
  end

end
