class CategorySerializer < ActiveModel::Serializer
attributes :id ,:name

belongs_to :restaurent, serializer: RestaurentSerializer

has_many :dishes 
end
