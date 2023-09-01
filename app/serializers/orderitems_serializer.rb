class OrderitemsSerializer < ActiveModel::Serializer
  attributes :id,:dish_name, :dish_price 

  belongs_to :order

  def dish_name
    object.dish.name
  end
  def dish_price
    object.dish.price
  end
end
