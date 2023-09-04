class RestaurentSerializer < ActiveModel::Serializer
  attributes :id ,:name, :place ,:status 

  belongs_to :user, serializer: UserSerializer
  
  has_many :categories 
  has_many :dishes, serializer: DishSerializer
end
