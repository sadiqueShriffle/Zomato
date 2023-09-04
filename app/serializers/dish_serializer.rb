class DishSerializer < ActiveModel::Serializer
  attributes :id ,:name, :price ,:dish_type,:images

  def images 
    object.images.map do |data|
      data.url
    end
  end

end
