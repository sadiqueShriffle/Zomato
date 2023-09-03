class DishSerializer < ActiveModel::Serializer
  attributes :id ,:name, :price ,:dish_type

  # def dish_image
  #   object.image.url
  # end
end
