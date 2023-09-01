class UserSerializer < ActiveModel::Serializer
  attributes :id ,:name,:email,:type,:image

	def image
		object.image.url
	end

  has_many :restaurents
	has_many :orders
	has_one  :cart, dependent: :destroy
	has_many :categories, through: :restaurents
	has_many :dishes, through: :categories

end
